resource "kubernetes_namespace" "devops-learning-namespace" {
  metadata {
    name = "devops-learning"
  }
}

resource "helm_release" "devops-learning-release" {
  name             = "devops-learning-release"
  chart            = "../helm"
  namespace        = "devops-learning"
  create_namespace = false

  values = [
    file("../helm/values.yaml")
  ]
  
  depends_on = [kubernetes_namespace.devops-learning-namespace]
}