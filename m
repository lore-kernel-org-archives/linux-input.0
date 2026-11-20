Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137146;
	b=IYWb3sixlE7/KawfZLNxILREE+0/sj3zIxN5LedAXCDMVPY7OxRaWV+TcJaKek+0wRhw
	 WnDQUZhY/TVNNEGObl1NmGOsyWn0pxIHu8V925AOYSx2UE4D5yst+XdyeMjF3auw5Xjy2
	 zhtRkWDviSqH7ELHv+VYWti/EArMitxb9i5FNiQAvihLjINoJs1uvJwyLiP2AZMiQEidh
	 fAVkCwsTaAkoBHZRFboxy1b0lies2s+zqDFEFjQpfAho6fyvxAoQANBM2JXUOEMnaHMzb
	 tEv+N5j2EaIYBroI3rdOFWAgH0KsQdCH/hE7jhPVmXpWZ4LMOWG5m11KnFhjoigJ14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
	b=dcCwc+TWGSiVv7L/QUoy4KE0l5rFyYTh9imLHUlejmYQ6zdQJoK2Y7GhddW6wKg3Nyju
	 mOWQnrKS0F5J2suPeUfyaJM7lvBA29FAGX0O2McClWwvOGjbJ68iFS+oGovLRxp8KkcyL
	 1urfEp/w8mTuMMey1QtxV+BYFXtbNylvnbHw+AZVEVnjUTx8j08JyVpZqNexD4anZHfLQ
	 e4z0W36Exotxjd4uDtesBhcP5jMHwPkQZTr+QicNYHtWBzU1mjiTDjkPiSeYcWSsCCL5w
	 86H/SLgb+qAtBTI0v2t26NEqVJMsMik+P4Iy/FY8gAX8RY25GAiuCtfL3j5g2axR7hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vX6Ne/6b";
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC536606A5C8
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 01:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC536606A5C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vX6Ne/6b
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3aec0b1d816so197948a91.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137145; x=1795741945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=vX6Ne/6bQ/4UZ8sumxqYuz35G1OsJVZY8r6kEm96WGyPZSYmlUYcIc+eAQvfyKgirI
         mqalQRpE0Y0mQuFiAxiIyr+TY91KeyHfpdhPFxbZvurra6CH5R2YAwScJap5KnLDt+Oj
         dLNw3RJQx4AQ6SnbVdc8EnT+A3oY09bzx4UvyF76QRjWWt0DN48I6p9vYIwwJ7K5mLrt
         0KS3UjI7IGldSuPP3nXAqmMs8KePOZES75jHhNIKbT52kSy5tLUTyfLwTkK1UoSq+vNM
         TSqFcELV17FzYq0FwMERFqr5Ln4dDWJbpyH7Bn8rg80HyYDec7kPtBESGsPnGbuIyILl
         jAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137145; x=1795741945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=FZnJWFnn5h0oS+lpaYGIA6cTpOKfPMfDjPxG6x5l9fK46r2bFeqbiyY3gaXw3tF7nh
         LPLQq5CXobwjmFDFtU/AkuUxJcJdPX04+fGIT2KIIQHT9xWavvY7GWx/xcn/qgEKPFfD
         dvTcFr0sZuF2jz2UnWc2w6V0u3HnPGZFACkV0CcevzUcROCUVcJsqfArA9vI/O5nkn1Z
         T6ILTU94PVdqt8N75HpqURT6JDnw58VoSMHyU6SgnT65SFFST/mREjYBWF4CnekqQX3H
         oq2Q6izEE4fa51ZS9HWkP8wW7A/AGqcdMklNZr1Mb6qjBDQyrR/xKxsmwR2EfS7SX0dD
         upXA==
X-Forwarded-Encrypted: i=1; AL+hErGIVV9Bli1Bi0Txws7vFGOHQrioRoGj5qgsixvM5WZEnsBHBi6SDfgL8UKJstL1Q8Mwgccp3ptc+lWuTQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z82y00NFAKX5qRkxlrcR6CcOb6fDfjDU8gY3KrMt1IycNnK5Ayj
	Fgazl73KP768yMMVFJBEXkjucWdMVWKqpIUnqu2WOir/9DZelFzOinxS
X-Gm-Gg: AZFdTZc/LIkFSZebF0WoBBW4Tic2Qc/fvZgQJ8gF0Kj4LL83/xfq87YWiCJKQdvJSap
	m7FtVF/vr14Az7oMYO6hFmMQTNRqdxF6iEw1uJNUzZVCcHgPjgR2SZDrrWhzdAc/8KMRCsyWnUU
	FZKK7eIaJCLT9wlttib08oS+BWFysjMRS7nfdCNxWiNpY+mStwYJqSozOEg5+n+MVAzgYJ+DHfR
	OBnBszCJlLKlyawwljup8u4qxKr6JMHmemJ6/XNZ0Q7U+qw5kFOyIRtfb0mbWVVrFJhdjDbbm1+
	X/eIr/7fbhBB7azq6N7FwEK2BwzcuDcbBtS/PW2pVbddmlWCnL8yiNSD2l0RuzoQPvvDOcdCavf
	CNWIxnAMbi0id9pIaKAhSmEDSj/tJVywfU85n15+vLQEotRBmDcRB6ug5HL/FOZEsnLmmz+FOtd
	XW4lAb99qpeF5S1mNJplSEyJ05G1R+sUbsrdgOYv0NoTX0Qcxt7d3AM5DpxyEkj6FGCljKPzRYM
	Q9xys/tVI/wxtzjjq3CrS2C1OYw819L5dkoEoxFcMztB+theSwHumwFBDsxltWcgVQYIwxMt6sR
	5tWmp4j9yYYrO6pJ0d0Nei5QFyGmmL0tW7Ha0MhYfqrivNkz86nzvPWLqHkdj49rO9Y7qXejbvZ
	lrbVwqgJxoQ98
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b41c95ce7fmr1046872a91.56.1795137145051;
        Thu, 19 Nov 2026 17:12:25 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:24 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Fri, 20 Nov 2026 12:05:48 +1100
Subject: [PATCH RESEND v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-2-d7531fa8061b@gmail.com>
References: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
In-Reply-To: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Closing the last framebuffer descriptor can deadlock against PicoLCD's
deferred update worker. fb_release() holds info->lock while waiting for
deferred work, and picolcd_fb_update() takes the same lock. Lockdep
reports the cycle through deferred-work completion and fbdefio_state->lock.
Repeated framebuffer open/write/close with concurrent device destruction
reproduces the hang in a PREEMPT_RT QEMU guest.

Use a private update mutex in the deferred worker instead of info->lock.
Take it in picolcd_set_par() as well to preserve serialization of pixel
format conversion and framebuffer updates. Initialize it before exposing
the framebuffer.

The test with the preceding output-request fix hung in the first round
and reported a circular locking dependency. With this change, all five
rounds completed, including 29 successful framebuffer write cycles and
concurrent LCD, backlight, two LED and UHID destroy operations, without
BUG/WARNING. The original syzkaller reproducer and persistent-open
framebuffer tests also passed again. These are bounded virtual-device
tests; physical hardware and suspend/resume remain untested.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred=
 I/O devices")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h    |  2 ++
 drivers/hid/hid-picolcd_fb.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 846a8ceb95..33e6654ca0 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -115,6 +115,8 @@ struct picolcd_data {
 struct picolcd_fb_data {
 	/* Framebuffer stuff */
 	spinlock_t lock;
+	/* Deferred I/O runs while fbdefio_state->lock is held. */
+	struct mutex update_lock;
 	struct picolcd_data *picolcd;
 	u8 update_rate;
 	u8 bpp;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index c17104fd60..258c7c4fa2 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -231,7 +231,8 @@ static void picolcd_fb_update(struct fb_info *info)
 	struct picolcd_fb_data *fbdata =3D info->par;
 	struct picolcd_data *data;
=20
-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);
=20
 	spin_lock_irqsave(&fbdata->lock, flags);
 	data =3D !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data =3D fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n =3D 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data =3D fbdata->picolcd;
 		spin_unlock_irqrestore(&fbdata->lock, flags);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&fbdata->update_lock);
 		if (data)
 			hid_hw_wait(data->hdev);
 		return;
 	}
 out:
-	mutex_unlock(&info->lock);
+	mutex_unlock(&fbdata->update_lock);
 }
=20
 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata =3D info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret =3D 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel =3D=3D fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	o_fb   =3D fbdata->bitmap;
 	tmp_fb =3D kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
=20
 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel =3D=3D 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)
=20
 	kfree(tmp_fb);
 	fbdata->bpp =3D info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }
=20
 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t off, si=
ze_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
=20
 	fbdata =3D info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd =3D data;
 	fbdata->update_rate =3D PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     =3D picolcdfb_var.bits_per_pixel;

--=20
2.56.1

