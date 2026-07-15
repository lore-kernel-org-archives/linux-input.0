Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB993B27C1
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133788; cv=none; b=CFYlXNYq3rmyVlv12PnTBfkxaUBmN3BrvkOwI2TjDK+vn0ojcREng+q8ulsl0N5NCshcsFIHb74mgPwQgQPTpq0r8qheF/vgSVefX71IX7XyjzAYf6ecKOSwCIfdBa3OncgyCF7RYVi7Qc8m1IX8W1Q/vbrTeJ3nWIhITVKOC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133788; c=relaxed/simple;
	bh=KIu+EvlorbnlKwwXdHIcvC3HLEpMtc0UtI9j2rJH8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCYwFdIY/ocndlXcjUETbhFi7cmrqdpmfyDXsEHNlkgey8jWqLeY+1lH7CkIBRpHE6FEZ9tsKjcsd06jIdCs8tfl8Y4uFo3isbnpzXb/Hqj3OVln55ir74XAIaaXZiwWwmRiWZ9Rf7xBx+0ffjx+bSOr7UE5OtrQXuAnJ4A0rV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew3ejZgS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew3ejZgS"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so9484262a12.2
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133785; x=1784738585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YyrwCmoer2aeH7zF0wwvp/QUbG2nb9e4P0wWSlLo9Ak=;
        b=ew3ejZgSrT/JpMbrjKB9RGve2mPRfM3Cf2Fs2Ulo7xwx3/QiB2ZXpiQ3QBp4NeQLxL
         bCzxE7Uv1LcZ/5QJpkYQ6BftA/5i4EXes0FaJGsorTyx6p5VhbfcAT4T3VdCVxqGMlQo
         UW8qu6xOe3BsNzXf/TmjPd9T4+tBznTNBEb5AH+oEDhHVgA0LhBhf/IrWCDdXSadbvHw
         oANJQpYgNZh19oX/+Sx1+XMU+QjnOfXBxcWsSa5jyuBexb6YEXUYn+wrYlx24nhvxKa3
         pGCWMcbQ5oo+MNQP9oesl0Q0m3sXcoXlu/tWmTm9SFYnoFJo33xP+vsWgRY+dyieqjX2
         eSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133785; x=1784738585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YyrwCmoer2aeH7zF0wwvp/QUbG2nb9e4P0wWSlLo9Ak=;
        b=HbuAVceaoJNzQDJx3La5lLya0Nb9GdLCS6d9TD3ka8nq7hvuNPX4sd0NTJwT1G4CVR
         +FiGnZ2sIHwgaJCmnrfDwr9jJcBfuDbyDEhNzz3suG9lLqru+zMMvs9WnFZ8vppA6c9N
         XHeRB0W7U9TK+tsRxbD9lRrnBtoh3Sy3ZmI1rEbBnPrJaYMAPscF1qNFX4mTXlfZk4gJ
         /ImX3GB6uoU+IXAanCyOpdU1KZg5UEhN4kYfHdTUvV6LQh43HUJ7rFd9So2MhpXGyL25
         vu7yOVsSJovX9rZ62MmNeEOs+jxel3jqXoOiLXw3az2MTulkeniVCQwV2vzajMC7oUEJ
         MB9w==
X-Forwarded-Encrypted: i=1; AHgh+RofGc/T5SFpoYavcL44yRyXtOvQCoCnx4r8XFvcGf43NzQLAued46wfCoRgAfcYg9NQncCzepUwrxpb8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCWjPLV5bSbTNMCOrXFiGA4D3Pt8JyPhs0jltMFAazAgKmUtA
	s/OrP4icTb3PkPEShDi/tCl5AYfC3PJnkpS5971RPGVDk4LuM8yCnT/F
X-Gm-Gg: AfdE7cllXB4dUyJoD2n7Ismqmw9q9JG4GbngF+Ni5x6G+LOzjKKNmpP3SfUqNCFnP3q
	8RjsB/R83cQw23+X9w9sgx2ji1YNSRAxTjDrenpMNzT0+wijALiWveNM8H4wSW2gP5p44H8HndO
	IxocAovF3qKR3Qr+SuYrCRGSfwVsdMhYC+4qyFzB1Jsi326yC/zsIwk/o+X8DiqKMq1r/t3cy4o
	44juuQ+izLHC8HNvuBGGbricA2LtebJUTjdD5yrRn2FeZC+COw69BiOGLh3FoZJ+7Gc5w7n76fl
	fatSN0/uukCf4UfMh3d7G77YGjtU7wLnEpHwQGzVb6S80NSLAUXWVL7kSUZOHp/aln3snpjh6K4
	2juDK05OeEf2xKOFDT+N37iYyJeUEcsOkTZyp6i1TZfbO1TrtMB+Zqvi1hZvaJLWsrrVRWCZ56F
	neihtm28GUFmsDPWQSCEFOxSAbxndbCOybomYQuOiD2DxXeYpLa7rNiLG8G8gq7DCg3B2EYe5HF
	sWU
X-Received: by 2002:a05:6402:1cc9:b0:69a:2ee6:4c94 with SMTP id 4fb4d7f45d1cf-69e1977783amr2054499a12.2.1784133784997;
        Wed, 15 Jul 2026 09:43:04 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd29213d7sm3503437a12.16.2026.07.15.09.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:43:03 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH v2 2/4] virtio_input: validate device-reported multitouch slot count
Date: Wed, 15 Jul 2026 18:41:58 +0200
Message-ID: <20260715164259.41060-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-3-harimishal1@gmail.com>
References: <20260715142337.22811-3-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nslots is derived from the ABS_MT_SLOT maximum reported by the virtio
device. A device could report a bogus maximum (e.g. -1) making nslots <=
0, and input_mt_init_slots() can independently fail too (e.g. it rejects
slot counts over 1024). Neither case was handled here, and
input_mt_init_slots() failing took down the whole probe, losing the rest
of the input device over a problem isolated to multitouch.

Instead of failing the probe, warn and disable the ABS_MT_SLOT
capability in either case, and let the rest of the device register
normally. This recovery assumes input_mt_init_slots() is called with
flags == 0: with nonzero flags it can fail after already mutating the
input_dev (e.g. via input_set_abs_params()), which this recovery does
not account for.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
v2: per review, disable multitouch instead of failing the whole
    probe when the reported slot count is invalid or
    input_mt_init_slots() otherwise fails.

 drivers/virtio/virtio_input.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..786f5150724f 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -312,9 +312,25 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
 			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
-			err = input_mt_init_slots(vi->idev, nslots, 0);
-			if (err)
-				goto err_mt_init_slots;
+			if (nslots <= 0) {
+				dev_warn(&vdev->dev,
+					 "invalid multitouch slot count %d, disabling multitouch\n",
+					 nslots);
+				__clear_bit(ABS_MT_SLOT, vi->idev->absbit);
+			} else {
+				/*
+				 * flags is 0: input_mt_init_slots() can only fail
+				 * before touching *idev, so the recovery below is
+				 * a full rollback.
+				 */
+				err = input_mt_init_slots(vi->idev, nslots, 0);
+				if (err) {
+					dev_warn(&vdev->dev,
+						 "failed to init %d multitouch slots (%d), disabling multitouch\n",
+						 nslots, err);
+					__clear_bit(ABS_MT_SLOT, vi->idev->absbit);
+				}
+			}
 		}
 	}
 
@@ -331,7 +347,6 @@ static int virtinput_probe(struct virtio_device *vdev)
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
-err_mt_init_slots:
 	input_free_device(vi->idev);
 err_input_alloc:
 	vdev->config->del_vqs(vdev);
-- 
2.43.0

