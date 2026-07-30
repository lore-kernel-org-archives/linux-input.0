Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFA392C4F;
	Thu, 30 Jul 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415985; cv=none; b=HG8gUb37O++T2AROCTkqXK2KfYUxZfKaxVhzHE5oR0C1sDLO5hAP4vrhyFxwc3yHHLOP4ZXyLezPb04rLoiPfatBdJkMhW+PsBRhQaO7+zAfSykGqqqljBtG7dW/TcXfl5k73mVYNty9z77SaM0CAAuUPKOznHy78MhyuTje/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415985; c=relaxed/simple;
	bh=0pVKDw7VTT5NTOCXE8Eb2zYY/zVZZZLssctGknNwaUs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bsKO6fg6rmhpZO+pRvKRil4tCMvxIm7g+9oqV4LNfHyxf9DsW/xFyxKbuT7/pswfSDx1ZHcjt1BT3jL8loxOKwpCG9UqFIAaVe3Elg8U4BiVPqhCO0+K7wl+QOXIaiLcK6nC54hVpRBBaHXDRBPr9tbD1TNLc6lpVn/Q17Bvamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NW9oI5lx; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NW9oI5lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785415975;
	bh=rohzAr17Hgx/FIVw3ixFYlsqi7P7a5Z48TtmBNIVHdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NW9oI5lxSLadNRLeM00KO9bJZJ6gOYFdbi7cjQ7gh3MFy52HeyKLig0ZdL6bVPpuj
	 NswqdxURtyOOjofPwgnAnd+bs+U5GOPDdQHxbKsD2GpNJTGfgNZh3/uYKWIraNlc2X
	 XdU05F81psknTuuDJ5PEjEsUJP8KCRxNx4/TvKeQ=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id D35390A1; Thu, 30 Jul 2026 20:52:53 +0800
X-QQ-mid: xmsmtpt1785415973tqy3df663
Message-ID: <tencent_6D1C4A793D4B3D07F0415D2A86B91BA33508@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL5jEYngCda9lz2KSSrAM08b1Mu74H2s9Fru5Aj4H52qWWa/sVIV
	 nx0dWqfhq93jm6IZXLYxT5K+Pjxw/Ias2hm2mfvzUI+0ZXm88KhWdokjuQ1ANt8tr8Er9qpQ0Jdx
	 wrFng5qdi+LbxyzcBfKT8r2JMEJNQHpdCkgpHDW6eHe9O4f754xnhvxetsP/LK9Q4aZZP1atT/Vi
	 S9XFa459jp6SpXR4N6q8UTePm5rfxcydZEzL2/q/WqBW5/Axa5A9y+AHsSgYgIeSPQHI/yZpaE8y
	 4Q8E3CLfJTdw7/M0GbtjuPBE0ZJYsyQjhm4sVsBuJwueDMdI7EB2FSl1aGoLYdPT0dDToeyhH11N
	 MymruKzGE5RnC44y/GafW5Z46ZmIIOICZ7sFLKC+nyqDWGPGf7NSU1qkiV8aZ7EVqwYROno+XTCw
	 vAADV5fUHHj4fDvF/fi1QSL5TOXxUvekw0qmFzlJvTOvKVPOHz7cOs2V71jdLp70uAZ/x9Ai/UNR
	 caAH47Gv1XDXhoVZPji7tfhETqnVlFUg9doM03H7J865GXvKDXdYeYML/Uw7mR6KnmyokwE8+zbR
	 MLrqbScYXQB4IsgoYsxjhsYfDevk6AhYB7pEYHw5+tgDH6+R7+7Z0dTJgMPtRB15rVEjlTOzCKOA
	 7kPN4iMXktCGdiDt2dEPOuKl3j9XiPtoNRTT7bbht4VnjKm8uGJ19wdEdjIbZsCk13o7K7Cu1B6q
	 p2HfzclfMfdBuP35h+uDYxxgXryBy66+Y2CbKnYGv6VTdGW7Xg7sYdqfnl4WdqcVKn022hltwjj9
	 V6hJMME8qL7/kKON9OL63bQQ6TlBa0TPLPayHU278bZag7ZS5owtmZ8MMAMiJtfwuIcWPhYAxjZ/
	 ojJdP1+siSj4Oey4frI+x4TIr11MwG0DXStGXB/qeFR+jgcfS9Gynl/BqJGe356TIXphxpQoj7eo
	 uu3NiZoabF0dtBYXKAklTBsGIXgaOPZ15U023VUkVrLEKy0guqq2lR4n+nYJUn71zOwZ56kThwc3
	 IyWhbWiPh6xSZGD5TzytiQBOXKKCGpBc+mwIWtM6HD8jKpwEERjZp19HRFjboCkhR45e+epdBiLU
	 rSjqAw
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shen Yongchao <grayhat@foxmail.com>
To: linux-input@vger.kernel.org
Cc: Shen Yongchao <grayhat@foxmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] HID: intel-ish-hid: prevent size_t underflow in report_list parsing
Date: Thu, 30 Jul 2026 20:52:53 +0800
X-OQ-MSGID: <20260730125253.294317-1-grayhat@foxmail.com>
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

payload_len is computed as report_len - sizeof(struct
hostif_msg_hdr) where report_len is a firmware-controlled u16
stored in a size_t.  Values 0..5 underflow to ~SIZE_MAX, causing
hid_input_report() to read far past the receive buffer.

Add an explicit check for report_len < sizeof(struct
hostif_msg_hdr) and use a local inner_len variable instead of
overwriting the outer loop's payload_len.


Assisted-by: LLM
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
---
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 6609130ce..efe5c5326 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -77,6 +77,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	u8 *pos;
 	u8 *list_end;
 	size_t report_len;
+	size_t inner_len;
 	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int curr_hid_dev = client_data->cur_hid_dev;
 	struct ishtp_hid_data *hid_data = NULL;
@@ -293,8 +294,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				recv_msg = container_of(&report->msg,
 							struct hostif_msg, hdr);
 				report_len = report->size;
-				payload = recv_msg->payload;
-				payload_len = report_len -
+				if (report_len < sizeof(struct hostif_msg_hdr))
+					break;
+
+
+				inner_len = report_len -
 					sizeof(struct hostif_msg_hdr);
 
 				for (i = 0; i < client_data->num_hid_devices;
@@ -306,11 +310,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 						client_data->hid_sensor_hubs[
 									i],
 						report_type,
-						payload, payload_len,
+						recv_msg->payload, inner_len,
 						0);
 					}
 
-				pos += sizeof(struct report) + payload_len;
+				pos += sizeof(struct report) + inner_len;
 			}
 			break;
 		default:

