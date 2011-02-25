From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2 2/3] Re-add manager_get_default_adapter()
Date: Fri, 25 Feb 2011 11:04:51 +0100
Message-ID: <1298628292-8842-3-git-send-email-ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:47727 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab1BYKIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 05:08:10 -0500
In-Reply-To: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Antonio Ospite <ospite@studenti.unina.it>

From: Bastien Nocera <hadess@hadess.net>

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 src/manager.c |    5 +++++
 src/manager.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index e805e0c..254ace4 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -262,6 +262,11 @@ static void manager_set_default_adapter(int id)
 			DBUS_TYPE_INVALID);
 }
 
+struct btd_adapter *manager_get_default_adapter(void)
+{
+	return manager_find_adapter_by_id(default_adapter_id);
+}
+
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
diff --git a/src/manager.h b/src/manager.h
index 05c38b3..4f92d2f 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -35,6 +35,7 @@ void manager_cleanup(DBusConnection *conn, const char *path);
 const char *manager_get_base_path(void);
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
 struct btd_adapter *manager_find_adapter_by_id(int id);
+struct btd_adapter *manager_get_default_adapter(void);
 void manager_foreach_adapter(adapter_cb func, gpointer user_data);
 GSList *manager_get_adapters(void);
 struct btd_adapter *btd_manager_register_adapter(int id);
-- 
1.7.4.1

