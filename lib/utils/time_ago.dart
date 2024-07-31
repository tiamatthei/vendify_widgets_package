String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);
  if (difference.inDays > 8) {
    return '${date.day}/${date.month}/${date.year}';
  } else if (difference.inDays > 1) {
    return '${difference.inDays} días atrás';
  } else if (difference.inDays == 1) {
    return 'Ayer';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} horas atrás';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutos atrás';
  } else {
    return 'Hace unos segundos';
  }
}
