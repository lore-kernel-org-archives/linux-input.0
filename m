Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CB3BC685;
	Thu, 30 Jul 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415979; cv=none; b=GzPfXjAATdBhxITIX5UMT2VN1kO2xcXcLUlUdjvyuiRz+EBzJDhmb4g5s+cUz4J7iiHY27/DiIx3pN9uuGjOaFMVfiaQfZiiqINqhC5NsFjbIpqrL/7huu6t4NutvzNpfV3qrIRyzeAsdH3iIC7jVqr8gDrDBM6uAjJGRigX09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415979; c=relaxed/simple;
	bh=iOdvuOKnU7e/S72T0bOW7u2+uE5A/B3RVfyw7sYIwgc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VMcAwytQnHPt1Tkn1jP4EmzeY2Fqi1vqDPmlhGsnZxDoGPXLmI3Zq93Zf5M00gNhiSZZQCfLHvY0voiBm1kEY4kpZ4jCiwSJvGxONurqG59NfmhPuDpEa29ZCBClFMlgkvk0XaEZ9zndXZzKnfLwJLzhbVYCSCba8llreaamRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JQD9Y2XH; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JQD9Y2XH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785415972;
	bh=6uPCuLRuN+pM5uwajhdIBPkX31WQIO6QOTJhMaEsJ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQD9Y2XHaYggNIcV+wyoy8mymc3GAkPETwIMp78whlQi3lkiPxakDhRNR20cRejiy
	 gVGfv/OlnMxt6w14tuE+C7rsxW9JZJnpedru5QxGhkh9vs8eBe7wM8G9Id6cyR8X96
	 FRp97sZu43YmqNXD+I9Qg90F+nwaDh1R7sTwFc6A=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D322C298; Thu, 30 Jul 2026 20:52:50 +0800
X-QQ-mid: xmsmtpt1785415970tqkm4y5sb
Message-ID: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb58WBoO07PjOiBD1kgsio3L7/aWBFXxrIu1DqjrhT4NDN82Qao4r
	 5KjJzHAvMAixlOfJIE+/Rsq0KIH/+iwQyNZgl/hwJkbMp96KmxdcWvcB4HQX0altv8vgWILpwk/K
	 8I8butu6rqWxtJucs90mWrJEmmONzmiZZc1e3rnfmhzW+auSiH1sVjxLLjoVF9uQ+MyomrOeNYxP
	 Bjs7YqIB+D9p1M3PDruc5q9R7mnCtud+kxUL2j3/y+ieNyPljseknzXSp7+9GuDQq6AsunlUefJs
	 UDmkYw0n2Z2gWgxjMXysGnHl2mvzq604lgNlhXJOzAxughP2zxGkutDIoJq3sckGuckqtXHrFwxy
	 46Uor0/C5UNpIZTlmADeS6b2kvDC5zJibU3Y4HkV7hg6oLDdDW8eOv9UE9j0eP8nFpX1BCOmAfbw
	 b+SHH9Flo5jdBSd7c0Imj+1uX84CluSQrRg8VZHtXFY6EDFo0wdClNj8bIgh0ihH1mGyrOahzR4G
	 IqPZa47MU3ZVC4Cmk443iR7ZvmE5RbS1RLhISC3gerF0NuhsotMdTrXkrAkE44K3BzI+A4cvcPSQ
	 XUN1f9PGX1VfMWraWaqanwfSQXD1OEd92OUEifC8ZytpvoSWXLGWW55CN1wzFnY79af2+m4v6mGs
	 r/oaOWEPNlgBcxcSLUEcWmcKPOYMUEhhXSgMTw5IVyUX2KQDknTASjPfyUmOBjoluL2hCHZqu4iB
	 OLTnOQ146aOOuczhYTF8u/5PnwcMNlyy3XA8QhMNFCE9sapT42GN57Nxa2vQG4+wdKuXE+xxb7xy
	 5dP1g7P4JqNn42zkjb+NiMni6pA6mKV2Ju5fTr3dRuXUESL2yz0y7jEAGT8GPinWzS2S5Mlk/0il
	 bK9jHbbUHB/t+B25oOK4jsJgexJqC0dttVjvnUTo2/b7CM4R7bZZKya9rGCz54/WiQ301oYYTpUl
	 EZxDxCcgZsCwRn4YhWPZFLk8FpeKEz/AhBZIRnUBG/fGwIzsdaYvyriQgDpeYde4wZqLk6JCerFe
	 e8ZvcOnTpByjxUQo3cu07NpyigL+bQXY6qYSK9MhtFODLHLzVOdW3bZ6BC8Mk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shen Yongchao <grayhat@foxmail.com>
To: linux-input@vger.kernel.org
Cc: Shen Yongchao <grayhat@foxmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator pointer arithmetic
Date: Thu, 30 Jul 2026 20:52:49 +0800
X-OQ-MSGID: <20260730125250.294211-1-grayhat@foxmail.com>
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

Since commit 63cafaf47a83 ("HID: ishtp-hid-client: replace
fake-flex arrays with flex-array members", v6.13), the
HOSTIF_PUBLISH_INPUT_REPORT_LIST handler iterates over sub-reports
using a struct report * pointer:

	report += sizeof(*report) + payload_len;

Because report is a struct report * (not a char *), the compiler
multiplies the advance by sizeof(struct report) = 8, making the
actual stride (8 + payload_len) * 8 bytes instead of the intended
8 + payload_len bytes.  On v6.13+ a legitimate aggregated list
with num_of_reports >= 2 drives the second iteration far outside
the message buffer.

Replace the struct report * iterator with a byte-granular u8 *pos
so the advance is computed in bytes.


Assisted-by: LLM
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Fixes: 63cafaf47a83 ("HID: ishtp-hid-client: replace fake-flex arrays with flex-array members")
Cc: stable@vger.kernel.org
---
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 6d64008f2..ba52e185c 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -74,6 +74,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	int report_type;
 	struct report_list *reports_list;
 	struct report *report;
+	u8 *pos;
 	size_t report_len;
 	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int curr_hid_dev = client_data->cur_hid_dev;
@@ -280,9 +281,10 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 		case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
 			report_type = HID_INPUT_REPORT;
 			reports_list = (struct report_list *)payload;
-			report = reports_list->reports;
+			pos = (u8 *)reports_list->reports;
 
 			for (j = 0; j < reports_list->num_of_reports; j++) {
+				report = (struct report *)pos;
 				recv_msg = container_of(&report->msg,
 							struct hostif_msg, hdr);
 				report_len = report->size;
@@ -303,7 +305,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 						0);
 					}
 
-				report += sizeof(*report) + payload_len;
+				pos += sizeof(struct report) + payload_len;
 			}
 			break;
 		default:
@@ -956,4 +958,4 @@ MODULE_AUTHOR("Daniel Drubin <daniel.drubin@intel.com>");
  */
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL");
\ No newline at end of file

