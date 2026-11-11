Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380188;
	b=Z5pYvAUrhzI1Uw/ImRp78vtDirAI0h3nYKADieAdRagGAaFMBZUD76tsHj0mai1Rhrsu
	 bc2g29psnqSb0LqH9XExPNxC2tyAFerju4SnxWrtJNMfa7r4F9Coj8sWQPD8PIZEObNI6
	 HOqvLvmwDNFcBRf16VmZniJ8ShJ8tvyk1xOGY2F0WPBmDRVlGwd9gGaL2TpCbQy5Ge4mj
	 aMM5+7yTT87JQIG/KjQqMlL2qcJ2I2JCvGrcVHXKPJCvHeOXRUG529ZcAv7eVjUV/3crK
	 Qo6I+MITOwrEFhO4CCfB+Mwr4WbsVTQAAOq2iu7KCCUoy3VJY+lxLxIVRYEDGLQRXDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
	b=0EHM6vOyWLRaeCIaEYRQcXD3DUffcFO71dZFSjJ7/G5HoKOojeqqWVPZQpgAqf22gcDw
	 pEmUkp3yAU56dYJOU/DrVGD6lVKrRRlpk2UqBPBAYuX8bjp9d02e2oJKaGzI9QdodHEwd
	 JmrEbnU9rpq9kyB0fZ1W4jBak1bJAqzkQyFyqNk4PPZ6/Dz5A5BUyi62Hdxd/vgMiaSXf
	 3O+Xs3ii0YuGzXZ3EmGweSbpxiZAPennpvi3KBRNz3mNXXFJBQH62ITj0Hz+8DVR/5cy0
	 /DLI2fsId5jDYb1qbu0ZXHMNazGk7BdxY8FN4mxD/c4VYV/vnOB/M3vFqoJSkrghjAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcmqKOta;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0A60A2631
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA0A60A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcmqKOta
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso4758951c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380187; x=1794984987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
        b=HcmqKOtaMbIzdNmicEoa8MVYrUmafrpOod9uwkTFjrysRnVzHZGMtl/av70cp5gync
         UzLIHltQXWLwB0bjPI0sv9CbgJBEXfE+hR73UkaYi99hP5CzsCFiG439hf4AKU5TKBcN
         wMeRqeo+6b0JA2siQOn0OYuap106vWCvd/0ekC2l+c9AlCFYvFMvcXCjxU/J97rLn7DE
         iDlfejyL+izOL/hUyiDI9cJrU7ZgmQUEF+98Hdl75vZ/t5gE14XG18w1rrQdWOMkbAfT
         M0/iuaRkAk21O6hnTxqU5nPY4Y81Ek5jAoWbl5WOPi0RLQRi4PUKwCSLjy2ST4KS1n6/
         ZvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380187; x=1794984987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
        b=ZACxxwVSPVTLboDEiSAIhaxetPjL8lmoCn/kB9PJFStCmI3ATwtKZmVlkOvAjLsZZG
         vq7vTkOhtG68TMRFhaNOhmfU+bQqTl4wxMxDSIgg4mRNLXkq6bmBqssXLuloSHNlB7tv
         V4skgFiweCjUokVcrZNmUZ6xIPmC2CGEosHIK5fnX1Hm1cARi8doWv3VZ7ym+xMVZNaS
         nEPYxkAP9Y6YfLegaMuR1Rq8rA7vDTL2er6Vgstkk4F417V6BuD3dZGlevbuHFL9Uqr2
         rqbUhTOrjVglM2NjvyveOHSyLYJR+7dP2dw43TEr267AzAAEPU/IhdcJX+FGC8BhpkjS
         BZAQ==
X-Forwarded-Encrypted: i=1; AL+hErHHBioliyslWEe5KApSqyxsSgPHQAA9dNEg4AIR0KFoNGC0mA2MBQ31dR+K8WzSFm02BGqIHutvgJfSrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uTpMIbcs16XX73QJIAuF5TzQjLTthaeY7X3lHgOLJyRdoPFxL
	ntg0d2r37+00U84eJN1otw/bQi6b+G2/Tmt9WW0bfVPS4+wA+c8adFLO
X-Gm-Gg: AYBFou0HOro3JcAcjuGEMyMpLTRHPqThE+NUamxRN+rcIR+z/UR7h/Itg9TeRrlrNUn
	idbIwo2FC+948pBqm0bgIcxQhVcY46HiwWMeKcS27bNZW3N38ACIJwBCBHjhRVQSXxBdAK31Go5
	fFqstmMhuv3t504ObS/k21fr7BPMVDjpTeJK5N+HHKywsA6L/dPGkWIjra2hUu4xtVKADdwFYSB
	NljpVvFtyKxFBKTTZBifxaboJAfGXVST/wQRMT1iQe7y1foDQ/phbGZYmjq5XAJ7/LESKZA3X7d
	XvjjqKqxWzogvCbOIsT4pd2pKYOxCquohst74pPTV5AgY59JJyHnoRxS7CWi7gO9FNKyqTY47Wq
	wLVQbaicDYEyWXMpjh8CT+LzWRaOMFlO8ufn4HynUmcFaWfyfj+PAxljYHX62F99j4ZBzWDSGCl
	JEXeF7qcr6OgfS2xnDG6T9+UXcoI7r+pTpaW3Kui4Bsn0oP+R5z9ycYsZf7C4BvFKk5fF+ttTUg
	VGOmlRsAjWt9VbSn1hZ647tDK6DjjHyH7hBhwHRPPVfEPZwcLGmsOgxZV6XGUHEK3qxpzMErx7B
	uFRBVJCRF8SjKngksWKLJ59CeaEm2bBOd7VRDlw5KUtF9OXJUjfbv3OpgV6w/noA7kbomzKxFvo
	C0KHBcX/WnUUmewolUA==
X-Received: by 2002:a05:701b:2504:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b3c0346852mr1464685c88.38.1794380187278;
        Tue, 10 Nov 2026 22:56:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:26 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:02 -0800
Subject: [PATCH v2 04/33] HID: logitech-hidpp: disable works before
 stopping transport
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-4-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Device removal and the probe error unwind path cancel the connect-event
and hi-res-reset work items only after closing and stopping the HID
transport, leaving in-flight work handlers able to issue HID++ transfers
or register power-supply and input devices while transport teardown is
underway. Moving cancel_work_sync() ahead of transport shutdown is not
sufficient because incoming reports remain active until the transport
stops and can re-schedule the work items before hid_hw_stop() completes.

Disable both work items synchronously before closing or stopping the
HID transport on device removal and on the post-I/O probe failure path,
and drop the unreachable cancellations from early transport start and
open failure paths where incoming packets have not been enabled yet.

On device removal where HID core enters with device I/O stopped and
driver_input_lock held, temporarily re-enable device I/O to flush
pending work handlers and disconnect input devices before stopping the
transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
reports can still wake synchronous commands without dispatching events
to the disconnecting input device.

Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d5f53b35ac6f..0e1a9fd98faf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 hid_hw_init_fail:
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
@@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	bool claimed_input;
 
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
+	hdev->claimed &= ~HID_CLAIMED_INPUT;
+	if (claimed_input)
+		hidpp->input = NULL;
+
+	hid_device_io_start(hdev);
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
+	if (claimed_input)
+		hidinput_disconnect(hdev);
+	hid_device_io_stop(hdev);
+
 	hid_hw_stop(hdev);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 }
 

-- 
2.56.0.542.g3ef89b7020-goog

