Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1E3C7E0E;
	Thu, 30 Jul 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415984; cv=none; b=kyv7FvLX4pErRkzfH7B6MvMgek2GvW1ED7//E2nvueyfya2jwey+0VW6SGgYzUewBNt0pNZZ/n4waNS1YwyM4xkbaj3cSKOXJMwmHJIMgJrz9fJBnp9QOcT4I8NsBVpJLuqJoLvT0B67JaLD6/zv3z7/IuxE/0urzg3QVCrNvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415984; c=relaxed/simple;
	bh=JcZTdBLPONSMN3g7pLniTsMh5cTd74d3w4mpm5xfLoY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sYyovcpaxjoVV+hFfAhJJCyUv+B9Vi1QaK5eMS2vxPB3ZK3hoCCHDYW5YISSj60RqZzuwpdMnGM8AyNo1bO4jK8uYKUWFKk6cPII/1IMXgr6IHk/XYM9rBv3e5V56D6MtOua5TCJ7yDUYNkYEW5adLxcv7//HNnkuSCZEmIveYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GFUuIy7L; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GFUuIy7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785415974;
	bh=p80+pukJdgAJAb7CITttv6/I59vuCl8XwyOmwQtbp3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFUuIy7L8e2nVOJEJAuFOygXC8VOv/P8fKn6gz6PReyZLNoyUWkihgHZPrwGaPJbj
	 nvsj47W3oXi3eE/loUUG8FF7hMcwQaqot5lRoECLjhdpFS5WlLdMbpCH9mtWLj4pkg
	 WYIb53i3SmR5XBDxtRfloPaUKaT840w8DzZKLI1g=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D339D47F; Thu, 30 Jul 2026 20:52:51 +0800
X-QQ-mid: xmsmtpt1785415971tkhq510jf
Message-ID: <tencent_9DD5BCA4258383AEA05715975CA7D16C0E07@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznK2zMH5TR8J037JBuJhMmPdpMvgNtqPdv741/9oPfjddnveZ/S+
	 lvI2Vh9J471tiQpYpgGFsBmYC4+SrQq1Xm6PimBppnf13aE1JbrjLHp/thtcpayzY7PWqvgPcnb9
	 UZfgC/P8QDfYUmx+bLrHH2plbsjlUoeCXYF5bS+9ANByiwwxpwWM1+be5zYufc2ZYER/MUOchDJB
	 x2q676bB/zBGae8vDylt5mpumadPFVnpRhsbE+txXKiDEYSxW+n7wrY3XsgA+qQcOnC/FDEM4A/s
	 KD+Clsiqxhy4pBbIkW3V9beRJbkrB9nO19qOjAbmj9wCpYJNulWd0ZpKdJgq6mgRSUbkQpoNp7Oh
	 ICaPu3JKJCsh4+nXKq8Kc49iCU66+SgbP1hq3GAMffN2hbudbpPISzYCyFU8KJDzfgSsNScu6gSf
	 Vb+pZyE1og0KT8MfrJteWmBnHC8+JxNjkTDqIWBKdg2mqwaodzvKW8LTPibe78yoH5UwEtFE5xYn
	 Dnp64w3Pdj120nFV9UvBItFMIHbxJ3Xtf8ReB32rmZaiitGYbFZ0RcwJjAbWFFrWKi6YA2iz5aCO
	 0cgJBjdJex1I8T77u68cOYsozrv70y+T2f7d/60fO8AYAajzrKNCkTjwjQRPQvFto+iwJQ4pZsXS
	 9Vob5nLBmkjVNNsiIgR0jeGxZVGuQdmUMmYRN7fQ2FWcCFBlwyq3PQWuHM6e3UJ70C7UU88ssbxD
	 RZ7jIEfWYCi16HCmQb8HUeh1uWRfV1kG9haAEcsvUNRFfDvOJANXQgq1kfr23eV0l2oXhyMrA5Z9
	 XXYmvyyhvPf9e9ZBzXOsJ9Y3MbQLTRtdZX5QfBg38s+alJntqjIcxuOzDsZoDWelmCJ3K87hqQLc
	 n1HOrUzSGDTtVfaFmfIbimsYD5EQ0bOve50KdoQqAdugzBNeTZFjGwqgoXZwdd/OEhcIymOhdNXW
	 efkQf8p2DtE3LyHWdmTel99HwnlPGf2e+CNFxM+ETZ7ly7KA8hqHvUXM5LftmmIOdyPW+/KGP84j
	 +tTZ9Ex/K2YS+L/xrA151OWmht0syJaR+923sNFRdzqgQoviZsqX3cZbebITc=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shen Yongchao <grayhat@foxmail.com>
To: linux-input@vger.kernel.org
Cc: Shen Yongchao <grayhat@foxmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] HID: intel-ish-hid: bound report_list iteration to message size
Date: Thu, 30 Jul 2026 20:52:51 +0800
X-OQ-MSGID: <20260730125251.294274-1-grayhat@foxmail.com>
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

num_of_reports is a u8 (up to 255) taken directly from the
firmware message, never compared against the actual payload size.
If the count exceeds the number of sub-reports the payload can
hold, the loop iterates past the receive buffer.

Compute list_end from the outer message payload and break out of
the loop when the next struct report header would fall outside
the message.


Assisted-by: LLM
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
---
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ba52e185c..6609130ce 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -75,6 +75,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	struct report_list *reports_list;
 	struct report *report;
 	u8 *pos;
+	u8 *list_end;
 	size_t report_len;
 	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int curr_hid_dev = client_data->cur_hid_dev;
@@ -282,8 +283,12 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			report_type = HID_INPUT_REPORT;
 			reports_list = (struct report_list *)payload;
 			pos = (u8 *)reports_list->reports;
+			list_end = (u8 *)payload + payload_len;
 
 			for (j = 0; j < reports_list->num_of_reports; j++) {
+				if (pos + sizeof(struct report) > list_end)
+					break;
+
 				report = (struct report *)pos;
 				recv_msg = container_of(&report->msg,
 							struct hostif_msg, hdr);

