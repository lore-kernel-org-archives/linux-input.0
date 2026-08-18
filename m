Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9F3CF1FD
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025892; cv=none; b=E1cXJFgirrhAgjgRWWs8SrEdT23ATXJGGCcXc2A5zdOOeoJiVpyloLXVfV7cS9weHsSxsdCnV2X8RG23AZnTHVIWyzQf4Zw3fT0qONw980R9gRUAkvcNC87pLnuCWKrH6HOZwkBcjbjdIUwJwwifu/ou7kzB65TKlgIkjEd6PjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025892; c=relaxed/simple;
	bh=D2qVT+5UgHXVKH/NVw1rp7Vf6w0Pz6v0HdW0WWpLAVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kR7z5EwFwIle3fAWgBrQ5ixQYtOehvqzfQEvLHgDES/n9hmb3FUE3CcQiIkLjguG2bmF0i7hFZDWLO53HsR4GOqm0+X/AhflKzGlmnYiwwF4p/CNl47ubdlZ+p76UuaM9MVP+TllxezSEA2GCUkFM8rFpjsx1v04IlQASltpG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN2DNiBs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN2DNiBs"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so2704313f8f.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025889; x=1787630689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Qe7iwTkU+6tPG7UhIEK+QFhp1l5M2wR4Ju/kRuD8cY=;
        b=KN2DNiBs8vyqiNzntB1ext9PPbaxYxbeJ6FkOv6OYYqWEYzPvgXeEV9egZG844Cu3s
         e55EHt9QcC//UiQ0933NGJy3TutR7blRQPksBssL8ZtHqJmAUW1VhMfrHya8WHsZYQ/Z
         IKbR3bGblAApx/HZjjahlQBtt+lAieUezcv4sWxsQo9MFIteHHIX2N7lUwRR++ltOLn5
         whM+OKksV1H5AgMM3t7ohMYZ8mVgYoG1Tq3V9toKvX3nDBVbDauylslwfPY51M6HTeWJ
         yZa9Jmf9L+38UlU0bwPhMaVlg0rtZmIhtoXzZyyEpT6gQOKsO+FBYoJyRG41fD5LBGhY
         gGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025889; x=1787630689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Qe7iwTkU+6tPG7UhIEK+QFhp1l5M2wR4Ju/kRuD8cY=;
        b=ePb6aTTKwqoVnmvGgcmcGUCmgwFRVK+P192fKAt8SIhBrPxEiz/+prT1refeaA7TGT
         wezYrGrUWPWFiX2tOMzdJOSQ9JXn3pv38v8LIhZYD/TALYwAtSdpEoQtX/2ahvKfW7sO
         vbz8UihEaoekVt29mHw2VGeeEqRgZz43Ta6NkED4RedR1Pkv1i150gPG2pTcA/F0AB30
         HBztTM+4mGOOfyD0ef01p4HFVtKIQrS4Ps7iKKJM0Iilzyga9OhUsEvkV5i6rhFrmAtw
         3AlqXMHc5RaIVYljza9A+2Tnz4UBzqagrXZAQ3TS8BYodLkP96Rw86J8JPGPvykZkJ3a
         YNvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3QbXStOBJUDNzFRzF6FTDJunfmNJrx1OPozXi28ExUX0XFj+hupF3ikGsuz0XRDu+8nMrmfRLBE64Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OqZJxFR47q/g7vCUvnQ2ZqilDrRbJ1gqB1xb+J+LSttC1U+j
	G/CxlqaJgmj6k+Srz/IoOQlKlfsya3eroNfQ0k3Q468HrHZbSYMgv/4D
X-Gm-Gg: AR+sD13cWsizhF6V6vdYtNm5DnY5Xgwmhx4LH6YcBf+TRREmKC4yLFLfzs0py2rZVtf
	3nLtBx5L/ttnOI0EjwUWN1x6z0t7uE1OvsiCc7CN00zwybd3BCk4UcdDNEN7LKI9XeK4t7pDVaH
	7NVXlJzHSKGsShetvFy+OQqP5n9THXiQcy411K3WnYeC/SsZVpkj1SDjk8nCgIPxsclWBq1XBMI
	vpjCOzvahfCmgmY97AcpmYQ6WDwwKcADj62h21E/4aoMOijsCoQdL6Fu9n9iTfAFpb3phfOqcbv
	WDHTDwCiqlR43tPusnRHpxdYbmL5msrCaU+7qO7aCmqjHndiEEEINiS68/jvi3wGDiFkYdE2Iq3
	borBFduil8goAxWNMpg112LBssey7m7Hzwg9wzHRRhU5EbhaBvNNCbxVB6K78icoMfwrFvnkdgO
	LWgdHS/21BhBBqNVUNRY3/MiiwJpoHSPuucY3j2OjhRwk5JI7K7ndELE3cxxtfGWj0xWzw8+rrM
	+qiWcERY10CSqjmHRYmHhawOxgtJYuDyURKJOmjWpIjhl2LQN1/7cKZja3jMntirq8EkxA11z1n
	IdzPqo/rHB4GXI5kXRPKzarTDnQcr5oHAYt9F+Rf2JoY/0SiWntL5lD++GyIqJ+vM+KwBJgKZMj
	Kuc5UrdM=
X-Received: by 2002:a05:6000:46d4:b0:482:a9d2:6afa with SMTP id ffacd0b85a97d-482a9d26b3emr4382292f8f.22.1787025889280;
        Mon, 17 Aug 2026 21:04:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio_input: stop callbacks before unregistering input device
Date: Tue, 18 Aug 2026 06:04:33 +0200
Message-Id: <20260818040433.66986-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtinput_remove() unregisters the input device, which can free it,
before resetting the virtio device that can still deliver events.

virtinput_recv_events() drops vi->lock around input_event() and samples
vi->ready only on loop entry. A callback that has passed that check can
therefore use the freed device, requeue a buffer, and kick the queue
after reset has begun.

A KASAN run with the race window widened reproduced the use-after-free.

Reset the device first, as virtinput_freeze() already does. Recheck
vi->ready after reacquiring the lock so the callback does not requeue or
kick once teardown starts.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e6828..12ff33b178ea3 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				break;
 			virtinput_queue_evtbuf(vi, event);
 		}
-		virtqueue_kick(vq);
+		if (vi->ready)
+			virtqueue_kick(vq);
 	}
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
@@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
-	input_unregister_device(vi->idev);
+	/* Stop callbacks before unregistering the input device. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.53.0

