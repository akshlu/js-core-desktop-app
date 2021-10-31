/**
 * Factorial
 * @value {Number}
 * @returns {Number}
 */ 
function factorial(value) {
	if (value <= 1) {
		return 1;
	}
	return value * factorial(value - 1);
}
