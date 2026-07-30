Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B893C4154;
	Thu, 30 Jul 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415984; cv=none; b=nzJpR6LLQfvXI8A/9NrxXskHxWXxjCUpre7TXuRzETjpxtJLu5LUyLPj4AL7k0k3JCQAThfB21YnD+hmWBewTuR2fxwUL57+82Hw1OpRgJ2igA3AjvB8q1i94eKav0z9iTiXllF/eCSerwZjLR+BrtYnqpYTsZLe/Nkoi0GSExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415984; c=relaxed/simple;
	bh=EC533UZ1iBNxkcH5ie25ne/ZA7sZCNbJSu78/xN9kVk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YTNhFqKWC3U5GF6bSkbD+Rt7R5NKJkpn5KSLzCUQstRNOzW5TS7dKNcfYYWWkS3dts2uGcrMlitRPhXXuQ0uGZmLxiF8jlvnWf48hy3eB1yPidoF7zqdQ5p6t0a0YicEa9nUhEh6drrh/QLRYJP9cR1c5YmaWBPvfub6MJNDebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=q7oRQfNg; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="q7oRQfNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785415977;
	bh=mUxWo3nitaj42/uWK8MMjzpXXCu5OCZ+NC2Ngw5/XZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q7oRQfNg7ELepPT+BUQXevM8qD0xpjIf0edEKhHYHVNT9D2OK4Vb15xVwZ37oqtuy
	 LCO560yjFTpRTfQfzrKekHRd17O3ShGa+pqXs/L6gKK2O8dC4VUM4J09B2qX3L0PBe
	 PUBPCbTAqPE6Ppacc3wLjT0xWm91suJoTstGZTew=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D37066DE; Thu, 30 Jul 2026 20:52:55 +0800
X-QQ-mid: xmsmtpt1785415975tncrhuw4e
Message-ID: <tencent_7441292A34B9A7A3111C7679504B7407B808@qq.com>
X-QQ-XMAILINFO: MZu/+/yIvVI0Rfk77xAZLnAokwThnPN5aU39H+3nbG88wzP2STOA7Y0tdM42wZ
	 Pc2XAttFUwk2d+6WQUSsE7/2l/1GUfeD7AgKvixO/NLZDvQJntFaxUuPth/4NnmM3Uqh+Rb2hmLX
	 SdHnjkaYC5wAYfleJ7RJaHlpegD7nes1S/PEq6wzbNS827O8GuZXL9mQK+zP1+xjcHMzO5JHdFWD
	 harRqlLWQ7NsxqcRmtbYo0gZKu0tKyQlp+5b3MgTsvLIhPoF/+ELEllsAwH3LylM77sWXH8vlJRj
	 2Pka9VTDHDifaRVS61suKXpWe7Kyss+l0HmIon5acBismdvOrdpeWZnj/iHBZWk++pgim8hv5KDk
	 6sKNjKahYgzOXBdMjzKtI4PeqqRTjYR5qe9dXOwQCWA/kiCoCg00iFooWB0GppdD7QkyqUUTY0yO
	 VqSigxE41is1/3bVlbe98sLT24mOjr+MuuHYaJyAqkQEjyWnL3TlQEOwUclgt2P1/0fsSgY2G7Sj
	 xhF49jkRViTi3E6lV2TTCdzwGHbRsLicBEr17FnsDvEoesRZ5qnW937i4Z47aUvsMCN1tzdTQfrq
	 UKR8D+UuUObT8lLyjzUQtczysQYVqlqlYAaG80A37uPJWhM8GfCVCzRKopQ3JiYD43Bt2p3ugNsG
	 G0Vl1bbcsmFTuHvVLG6NHKghMpPLeWAzX1eXvit+OQEEGkEgkAyXBa7lrfmX+W6e1LgLfvyMsrwc
	 DuGS5zCkDyatNQ6lZ+OQ3pyfHI8l0hvyq8paZ3o1YvXQ5C0M3YbgbotKZxdp7gOdKfyH7pvvVbni
	 piqdwUBB5LFd6kJqlClqccwsNm1HsaV0tuoowVVQbx02xjJ1oE58NOzeSr5lWLaNXMlkFmhTwTaO
	 Zz6/xJnvA8bpktpIQ+PTFLTyzcTUV3tokO0gPk3Ct+7b+5QIx35SlQx1xSLYGS9l6PZTJdsJ9K8F
	 OBOkXhaXTXMREMOuTYkRdYKjRxApYnIuuSXgzpLDSgGHuvXg17EfaCNntcNnu0gHptD2TJjwNXMU
	 Vq6hxWvT796hvTLQdpjDzIKugrg9MCmoHLiiikOk0pTId9qrV6SOZrg7s/2LoygzV1i9tgE1+y7i
	 P2jfEfmdwCoAYapyE327rMAhqpLA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shen Yongchao <grayhat@foxmail.com>
To: linux-input@vger.kernel.org
Cc: Shen Yongchao <grayhat@foxmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] HID: intel-ish-hid: add full entry bounds check to report_list parsing
Date: Thu, 30 Jul 2026 20:52:54 +0800
X-OQ-MSGID: <20260730125254.294381-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730115600.218172-1-grayhat@foxmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The report iterator is never checked against the receive buffer
boundary after computing the sub-report length, so a crafted
report_len can advance the iterator past the message and
subsequent iterations read from arbitrary out-of-bounds memory.

Add a check that the full entry (struct report header plus
payload) fits within the message before processing it.  Also
switch the reports_list and list_end sources from the stale
outer-loop payload variable to recv_msg->payload, which always
points to the current message.


Assisted-by: LLM
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
---
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index efe5c5326..0ac7be0c4 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -282,9 +282,9 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 
 		case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
 			report_type = HID_INPUT_REPORT;
-			reports_list = (struct report_list *)payload;
+			reports_list = (struct report_list *)recv_msg->payload;
 			pos = (u8 *)reports_list->reports;
-			list_end = (u8 *)payload + payload_len;
+			list_end = (u8 *)recv_msg->payload + payload_len;
 
 			for (j = 0; j < reports_list->num_of_reports; j++) {
 				if (pos + sizeof(struct report) > list_end)
@@ -300,6 +300,10 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 
 				inner_len = report_len -
 					sizeof(struct hostif_msg_hdr);
+				if (pos + sizeof(struct report) + inner_len >
+						list_end)
+					break;
+
 
 				for (i = 0; i < client_data->num_hid_devices;
 				     ++i)

