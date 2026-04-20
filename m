Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BA3A758C;
	Mon, 20 Apr 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711935; cv=none; b=BI7J44Z9+PngzR3s1AAV7pM+ylp9bSSY51Fbs2CNm7bIi2HYqF2jVZlIUoJP1cCsGvvrZIjET+14dv5CbvIuyqB5lPRf0rgoicWXo+4mkW2cAZdJb+8mVWpuq8r7EZyprId5ops6pqMxr9woNGXclDE4KfxZMJAkMM/wksXzuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711935; c=relaxed/simple;
	bh=XgW4QYPS5kTqM0w2kxIea5GLDUvVoZyEea4mI4ONZBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vws5JZ+suLLxWre20D2+sg8/1ZMGMCt2EG2pdzWNJ/NvNsQfhLOZHN9EoAkjf/89TULlOiBTA6r3WkR3fpkV/lGQOobUTIaNSOSki5O5CN4/hEqTW57R9eymAAh8ed2LwsWvjQCaF7WoIG2Mnf6wA3bRr4QiAEaBHLGwm0p0/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nboAmfvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nboAmfvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82252C19425;
	Mon, 20 Apr 2026 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776711934;
	bh=XgW4QYPS5kTqM0w2kxIea5GLDUvVoZyEea4mI4ONZBc=;
	h=From:To:Cc:Subject:Date:From;
	b=nboAmfvcUUYAdy2CozRFihkisF7kprwtug37SdGtZyy0DvATKV42CTvl2NaXMVp9+
	 EIoIvlas15hXa/msgQMZuRvgSJxe188fim4urbe4hT9IHPMa9EuE1brlXbnO+NRSDb
	 rbGYtdiZt3oNDs0upoQEfLBzujmf9MR8OD2083q0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH] Input: ims-pcu - bound frame parser write index against read_buf size
Date: Mon, 20 Apr 2026 21:05:31 +0200
Message-ID: <2026042030-mobilize-suspense-88f9@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=XgW4QYPS5kTqM0w2kxIea5GLDUvVoZyEea4mI4ONZBc=; b=kA0DAAIRMUfUDdst+ykByyZiAGnmePuhhRcIpWw+ocp/4y0u2BYbP57uvXsu67ao/yX0sY1pJ IhdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmnmePsACgkQMUfUDdst+ym2TwCgzIhF B9sz+b/PvR5gGMh7UOsYFjkAnRFAO0Ghc9UwLiRJL3PFFVgMgKEw
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
that accumulates frame payload into pcu->read_buf[] using the running
index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
read_pos is u8 but of course, we don't check the index before actually
writing the data :(

Fix this up by properly rejecting the frame at the first attempt to
write past read_buf and resync on the next STX, mirroring how the parser
handles short and bad-checksum frames on ETX.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/ims-pcu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index f69de9762c4e..87c66483b493 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -451,6 +451,8 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 
 		if (pcu->have_dle) {
 			pcu->have_dle = false;
+			if (pcu->read_pos >= IMS_PCU_BUF_SIZE)
+				goto frame_overflow;
 			pcu->read_buf[pcu->read_pos++] = data;
 			pcu->check_sum += data;
 			continue;
@@ -491,10 +493,19 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 			break;
 
 		default:
+			if (pcu->read_pos >= IMS_PCU_BUF_SIZE)
+				goto frame_overflow;
 			pcu->read_buf[pcu->read_pos++] = data;
 			pcu->check_sum += data;
 			break;
 		}
+		continue;
+
+frame_overflow:
+		dev_warn(pcu->dev, "Frame longer than %d bytes, discarding\n", IMS_PCU_BUF_SIZE);
+		pcu->have_stx = false;
+		pcu->have_dle = false;
+		pcu->read_pos = 0;
 	}
 }
 
-- 
2.53.0

