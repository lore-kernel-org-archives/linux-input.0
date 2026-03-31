Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D023C196A
	for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942862; cv=none; b=Kcy2cWLLyKj3dNKq9Mw1kIZirsUFooZ37jGmu1a4oz6vx2Wwiw2ZFsSV7ZRQzonGulT9M80MjoiY0U1FcNtp6V1TGBr97QHdrl99LaDbLNE+qBaln2xB8sfOzgnMQPTcjB75K2DoBPhx72+VFU61mZu3bl5pN0VOgjd5OzpniLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942862; c=relaxed/simple;
	bh=nSOeRy9yjh9m3FQneok9U0OvjSYiWqO2RbCLMu4zLnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eu316UgcxXDTmCVhh/x7tFk7Xl+gah6RbNwSPfT+M06Jf64yu8ufjZBuSnf7fhIaHChY3OhaTmWsTji9bPD8KKE+7+4GbKOC+bP7BX+qY2q0FMZKNnZyj5WzKSp7oCP7OiyypM13taxMj3q4eOagYlebcitSG6AZi1yTABLKBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTM7ZsOk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTM7ZsOk"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4887e4b338bso2348925e9.1
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774942857; x=1775547657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMHyAJ93rDGMSG71PUrqZFXXLKPTxBZ/U5bGQv1HBLQ=;
        b=KTM7ZsOk3ML3QGj4L/R9CMG6U3kk/+syLp4P7RPrcdOiXmBqQxQ1zDNsYoaFEr2FxB
         X1w1gTFD3+I3mS3eaitk1v98u2mxWyQ6ahRaWVPZlkVvMdlPtSqSlSMoJDntrl357UzX
         Ye29/8JzkaqpEaL9ZR0J1zIDE9SyCBpgT22xN6V1vdbA0xQium+HGf4+54OnLdd4VMla
         Wyhzv6oca3Ur2EIi/Htb+cLnUY5T2H908nAx7+Tapx85vb1yrJ0t58RSgRXZw0Q0dM7p
         dQLWq8L7MxK3/bdgXt200yuM08u4gmHBGHfw0xR1S3xBPX9OW51TuI+CoaaEbAtIpvUB
         dXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942857; x=1775547657;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMHyAJ93rDGMSG71PUrqZFXXLKPTxBZ/U5bGQv1HBLQ=;
        b=dc8jKBSKO6d+82QFK4eLePgCLvB1lqzN7RrMOW814rf4mm15RQxgRWI74crFU+3zPc
         wiooHqCALE2ojdVojSFGCMq+m1AAQSbiU/etnYmpcW8Y8Fxtv+YcCj1Thq+K+3+9zMu7
         v0Eq1B27MqLMUKh2NKY12JLeBcR/EuicB84j+UlN/Ud54yXL01Cb7PWXf6bvBYzwdM2x
         4Xx/cjgjNQDlvQeYemgk0GqmU60dtr1R4XmI3WoMM7xAqsCQfPeOheLHck0FdWM5sLAC
         yEJG1Lwx0F6Yy4xQk5orfX41gssjoyVifWlMjW7Dh2yzDwSaKa7VFtCfIKpq3JxgbHT5
         TyuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZaf8K7wdK5V7SWVHrj/FisS9y+x8eqmu9FE8oHTGczHpCrOCa50kCdfKxezOcTnJ/u94wqulnvTCP9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmngnSp4LOzNGrfH3XbSvonf3USG5BzaM+0b2qh+mRBu32Apkp
	6i+BzUGn3ChdDRV3wvvhRvmSChUnY2JWuYtpnH+P0ZCHKcH463I34+3dLCwrRaB6BV93qetvrlO
	isCe6ZA==
X-Received: from wmti11.prod.google.com ([2002:a05:600c:8b8b:b0:485:37cb:adc1])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:83c3:b0:485:3428:774c
 with SMTP id 5b1f17b1804b1-48878281a4cmr39196805e9.4.1774942857164; Tue, 31
 Mar 2026 00:40:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331074052.194064-1-gnoack@google.com>
Subject: [PATCH] HID: logitech-hidpp: Check bounds when deleting
 force-feedback effects
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Filipe=20La=C3=ADns?=" <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without this bounds check, this might otherwise overwrite index -1.

Triggering this condition requires action both from the USB device and from
userspace, which reduces the scenarios in which it can be exploited.

Cc: Lee Jones <lee@kernel.org>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-logitech-hidpp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index d1dea7297712..5f63f1d2303a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2502,12 +2502,15 @@ static void hidpp_ff_work_handler(struct work_struc=
t *w)
 		}
 		break;
 	case HIDPP_FF_DESTROY_EFFECT:
-		if (wd->effect_id >=3D 0)
-			/* regular effect destroyed */
-			data->effect_ids[wd->params[0]-1] =3D -1;
-		else if (wd->effect_id >=3D HIDPP_FF_EFFECTID_AUTOCENTER)
-			/* autocenter spring destroyed */
-			data->slot_autocenter =3D 0;
+		slot =3D wd->params[0];
+		if (slot > 0 && slot <=3D data->num_effects) {
+			if (wd->effect_id >=3D 0)
+				/* regular effect destroyed */
+				data->effect_ids[slot-1] =3D -1;
+			else if (wd->effect_id >=3D HIDPP_FF_EFFECTID_AUTOCENTER)
+				/* autocenter spring destroyed */
+				data->slot_autocenter =3D 0;
+		}
 		break;
 	case HIDPP_FF_SET_GLOBAL_GAINS:
 		data->gain =3D (wd->params[0] << 8) + wd->params[1];
--=20
2.53.0.1018.g2bb0e51243-goog

