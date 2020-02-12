;hechos
(deffacts hechos
	(saludo))

;reglas
(deftemplate usuario
	(slot nivelRiesgo (type NUMBER))
	(slot horasSueno (type NUMBER))
)

(defrule saludo
	(declare (salience 10))	
	=>
	(printout t "Hola, este es el sistema Depre IA, ahora te daremos algunas recomendacines  basandonos en el nivel de riesgo que obtuviste en el cuestionario." crlf)
	(assert (ingresarDatos))
)

(defrule ingresarDatos 
        ?hecho <- (ingresarDatos)
	=> 
	(printout t "Ingresa el nivel de riesgo: " crlf)
	(bind ?nivel (read))

	(printout t "Ingresa las horas que duermes normalmente en un dia: " crlf) 
        (bind ?horas (read))

	(assert (usuario
			(nivelRiesgo ?nivel)
			(horasSueno ?horas)))
	
	(assert (recomendaciones))
	(retract ?hecho)
)

(defrule recomendaciones
	(usuario
		(nivelRiesgo ?niv)
		(horasSueno ?sue))
	?hecho <- (recomendaciones)
	=> 
	(printout t "Recomendaciones: " crlf)
	
	(if (< ?niv 11) then 
		(printout t "Obtuviste un nivel de riesgo bajo, eso está bien, si lo sientes necesario consulta a un psicólogo." crlf)
	else 
		(if (< ?niv 21)  then
			(printout t "Obtuviste un nivel de riesgo medio, pero no te sientas triste, hay personas dispuestas a ayudarte, deberías consultar con un psicólogo para que te asesore con las dudas que tienes." crlf)
			(printout t "Puedes hacer varias actividades que te ayuden a sentirte mejor, como salir a caminar, practicar algun deporte, o incluso hacer trabajo comunitario." crlf)
		else
			(printout t "Obtuviste un nivel de riesgo alto, ¡No te alarmes! Te recomendamos que solicites una cita con un psicólo en cuanto puedas para que sea él quien te ayude mejor." crlf)
			(printout t "Puedes hacer varias actividades que te ayuden a sentirte mejor, como salir a caminar, practicar algun deporte, o incluso hacer trabajo comunitario." 	crlf)
		)
	)

	(if (< ?sue 4.1) then
		(printout t "Al parecer estás durmiendo muy poco. Esto puede tener consecuencias en tu salud, como fatiga, cansancio y excesiva somnolencia diurna." crlf)
		(printout t "Entendemos que no siempre se puede lograr dormir lo suficiente debido al trabajo u otras cosas, pero te recomendamos que intentes dormir un poco más y que consultes a un médico, puede que tengas un trastorno del sueño." crlf)
	else
		(if (< ?sue 7.1) then
			(printout t "Parece que no estás durmiendo lo suficiente, recuerda que esto puede afectar tu salud y disminuir tu rendimiento en tus actividades diarias." crlf)
			(printout t "Intenta dormir al menos unas 7h30min para que des lo mejor de ti día a día." crlf)
		else
			(if (< ?sue 9.1) then
				(printout t "Tu tiempo de sueño es el adecuado, ¡Qué bien!." crlf)
			else 
				(printout t "Parece que estás durmiendo más de lo recomendado. Te recomendamos que consultes a un médico." crlf)
			)
		)
	)

	(retract ?hecho)
)



