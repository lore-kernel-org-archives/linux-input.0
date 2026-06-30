Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B37E2E5;
	Tue, 30 Jun 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803977; cv=none; b=DhLp7KRD/KoJeVg2dB4Jd2iRtlcjX2Peyo9IFxEHOEZF4U/WsN/w2c0JVIpOddSw0q90okqVfKtdzCIajMzgmFA92JlKEy5KMt+ZSLXtNJlufLBHMfnVto0lDQFba80r3iIJGIA3C/KXr+o2dLO4mRb7X0H8tduPGwNlzVTLPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803977; c=relaxed/simple;
	bh=CYMQhdODRCOy4W3O1MJRjpHOpd9V1ZUjUjhGJX3/pPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSBE1+1AqsHy6XwnKuPWmyo2Lnw6SwA63Th8wx9vY0liyLq+1QoQ7foq0qLDdBfU3/IMXqJF+lVbgvKwbo0k0XJuf5A7EspWvXpskg6/lH4uGKlVqslFRlg400Muip83fGRfEVn6sFZ7n+51mRBD1SD+gg5gOl+HxGPL+n2tqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0008-Input-cyapa---validate-unsupported-PIP-response-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAA3xgkFbkNqBDkkFg--.8534S2;
	Tue, 30 Jun 2026 15:19:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:INPUT KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN..." <linux-input@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] Input: cyapa - validate unsupported PIP response length
Date: Tue, 30 Jun 2026 15:19:33 +0800
Message-ID: <2026063008017969.1-ccfa108-0008-Input-cyapa---validate-unsu-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3xgkFbkNqBDkkFg--.8534S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rKw4kKF4DKr47Kw15Arb_yoW8tr47pF
	9093W5uryUXa9xtr92yrs8uFW5GanFkFy5KayUX3WfZw1UKFW0gw1IkrnFvr1qvF1rur4S
	grn5AF4a9rn8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUya14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

cyapa_sort_tsg_pip_app_resp_data() accepts PIP application
responses after checking PIP_MIN_APP_RESP_LENGTH bytes.  That covers
the application command byte at offset 4, but the unsupported-command
path also reads the status byte at PIP_RESP_STATUS_OFFSET.

A short response can advertise PIP_UNSUPPORTED_CMD_RESP_LENGTH in the
response header while the supplied buffer still contains only the generic
minimum response.  Validate the unsupported response length before reading
the status byte.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/mouse/cyapa_gen5.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 59f6e97..733da6d 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -686,6 +686,7 @@ bool cyapa_sort_tsg_pip_app_resp_data(struct cyapa *cyapa,
 		u8 *data, int len)
 {
 	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
+	u8 cmd_code;
 	int resp_len;
 
 	if (!data || len < PIP_MIN_APP_RESP_LENGTH)
@@ -694,13 +695,19 @@ bool cyapa_sort_tsg_pip_app_resp_data(struct cyapa *cyapa,
 	if (data[PIP_RESP_REPORT_ID_OFFSET] == PIP_APP_RESP_REPORT_ID &&
 			data[PIP_RESP_RSVD_OFFSET] == PIP_RESP_RSVD_KEY) {
 		resp_len = get_unaligned_le16(&data[PIP_RESP_LENGTH_OFFSET]);
-		if (GET_PIP_CMD_CODE(data[PIP_RESP_APP_CMD_OFFSET]) == 0x00 &&
-			resp_len == PIP_UNSUPPORTED_CMD_RESP_LENGTH &&
-			data[5] == pip->in_progress_cmd) {
-			/* Unsupported command code */
-			return false;
-		} else if (GET_PIP_CMD_CODE(data[PIP_RESP_APP_CMD_OFFSET]) ==
-				pip->in_progress_cmd) {
+		cmd_code = GET_PIP_CMD_CODE(data[PIP_RESP_APP_CMD_OFFSET]);
+		if (cmd_code == 0x00 &&
+		    resp_len == PIP_UNSUPPORTED_CMD_RESP_LENGTH) {
+			if (len < PIP_UNSUPPORTED_CMD_RESP_LENGTH)
+				return false;
+
+			if (data[PIP_RESP_STATUS_OFFSET] == pip->in_progress_cmd) {
+				/* Unsupported command code */
+				return false;
+			}
+		}
+
+		if (cmd_code == pip->in_progress_cmd) {
 			/* Correct command response received */
 			return true;
 		}

