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
		(printout t "Obtuviste un nivel de riesgo bajo, eso est� bien, si lo sientes necesario consulta a un psic�logo." crlf)
	else 
		(if (< ?niv 21)  then
			(printout t "Obtuviste un nivel de riesgo medio, pero no te sientas triste, hay personas dispuestas a ayudarte, deber�as consultar con un psic�logo para que te asesore con las dudas que tienes." crlf)
			(printout t "Puedes hacer varias actividades que te ayuden a sentirte mejor, como salir a caminar, practicar algun deporte, o incluso hacer trabajo comunitario." crlf)
		else
			(printout t "Obtuviste un nivel de riesgo alto, �No te alarmes! Te recomendamos que solicites una cita con un psic�lo en cuanto puedas para que sea �l quien te ayude mejor." crlf)
			(printout t "Puedes hacer varias actividades que te ayuden a sentirte mejor, como salir a caminar, practicar algun deporte, o incluso hacer trabajo comunitario." 	crlf)
		)
	)

	(if (< ?sue 4.1) then
		(printout t "Al parecer est�s durmiendo muy poco. Esto puede tener consecuencias en tu salud, como fatiga, cansancio y excesiva somnolencia diurna." crlf)
		(printout t "Entendemos que no siempre se puede lograr dormir lo suficiente debido al trabajo u otras cosas, pero te recomendamos que intentes dormir un poco m�s y que consultes a un m�dico, puede que tengas un trastorno del sue�o." crlf)
	else
		(if (< ?sue 7.1) then
			(printout t "Parece que no est�s durmiendo lo suficiente, recuerda que esto puede afectar tu salud y disminuir tu rendimiento en tus actividades diarias." crlf)
			(printout t "Intenta dormir al menos unas 7h30min para que des lo mejor de ti d�a a d�a." crlf)
		else
			(if (< ?sue 9.1) then
				(printout t "Tu tiempo de sue�o es el adecuado, �Qu� bien!." crlf)
			else 
				(printout t "Parece que est�s durmiendo m�s de lo recomendado. Te recomendamos que consultes a un m�dico." crlf)
			)
		)
	)

	(retract ?hecho)
)



