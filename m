Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473D367288
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125438; cv=none; b=t12usFEz38Q7zkphnnLTx05arjBSorHtmplRwxh73DAMGTZztalm4jyRJnwFIAcisUj+301BiZYbO/y/hSvt9wLM87mdduAQ2Aynxot/pu/5DjA26Wb8lOuyD/eN0bWGiIcQ8EW/2025VWQVT19NJp/YrJ5mDQ6MgzhbaiugDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125438; c=relaxed/simple;
	bh=tWfme+tzQ9G7mAqvSYSvjdoyZ1LogMZJCZU9ph6QRJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkQ35oxxouXIGoFNWls9GeK3t2Lu5SnQuvtURUL+FJJM4Xr/l9mwTPpwTKoSpDJAi4pvE8nbZ2sf+cXExxCtwtJCmtRZIAJotcwxL6cAPjcrBQDUhDz0txd/jt+gsMI88HlcV9G2jRKLK5xrqieEKxbZzQCTFcpR4SSugEB/G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAws+HHz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAws+HHz"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso1030078a12.2
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125432; x=1784730232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSGPZtrn7btUtmz6wHgzIANbziCZWoxzvDyAbH1+WOo=;
        b=kAws+HHztRTcyg2oihmMwcDNX7VnDiwdViERgV75b1VZOpIZj3InOlN/wkwkN6vK6v
         u+UaOcC6BE3OloQeixXBxz9Stl5JsIkgmAUssJgv/Nbn5rB8y/tU7/pUzh2URcH66co9
         I4Qz5cJ6mv+8mqgz+gIykIjxtR/ksJCmpErZ6OKnaBl6fpElPv1JqOaYxkfR9KUWVP0y
         lEVwpP3fb347Dga6lSXoGwm8xss2MmkiiPhajTvbwDQ2qEFoyuNPm3SyE/SLgARYVmVJ
         znXlgdUz+M0k05HBvrIf3mFSP039xsaM51d8ZCMzHRCfhoCiL9vOW9NLI9h/9Flvd5oN
         LwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125432; x=1784730232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSGPZtrn7btUtmz6wHgzIANbziCZWoxzvDyAbH1+WOo=;
        b=rvhen06YpMFu1PDOtKuI8S/ATAJ2zrfrk6c75fYm26HDIL8XRXSMFTWkojkZvuwli+
         sa6qqKl0CtZzd7Iu3Lag5SXqhRnwVm0bdKgcPDWOhGlOgr6osRjCjI24qEiD2sSMk30x
         lfnZ9ck18R1YjDMcDokaQAKWtODsogJWPhcANhbWWrgxG3/xamp2xXjnctFEf3k1r6Z0
         0o/PnE+w79cgXi4+JSDo98YfJK1j5VUmRGWZmmfPk4Z4WGPK8sDGl0Ayh8V4IkxgVkxL
         FFGRvCHfypVAuXqRwRnjTNDecdpwu76JDrJL05sytpcqhvn00Y7FuUmYIRby1LAfJ7d+
         /KNg==
X-Forwarded-Encrypted: i=1; AHgh+Rqd6vn0NSfR/sUdsU1d4tFQqbFG/DsmqK+Quyrm+qZHyUed+YzfahNqVaF3NkaWP/Kkhm751HvvplDe1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSj4vIsuv9lKmkxkvrT/4+8UAHKtFIlhyrP3SMaiLDIfe9iz1
	sICYz5tJqXRflOK1yBbijs/Wg1az9eqITGh7ts0yeZ5I91PD89jjFXFI
X-Gm-Gg: AfdE7cnbaDi8YwR6amiIKE2DmFdwU7gmJAkaS/wgJkeGLg+WZk56omljnWvI1vi6SwU
	74EHcbPI/AXet9QvKQMFsS2scETu22uvk7NcLzeyhEcDpVeuG25CznheSohlk/Bubyxa0zFPBn6
	kwiGLoMo9CNPrsSobotm49FqwhcNEtz9hAVxp+GgZWHKe1ANVxpf6T8vR18VBxNilzKPMsrXJwZ
	QzhGDf5rpy+xz58MMowUa53SafdlDYEi2yf3cxVlKl+xVhz90YaR0CdDQ5DfehwAyNuHel2Id6d
	cuBlhhFhFFbe/qElafmiJigkDJVROf/pUIsObLhAIBQAtNYyEl/33b2uAw3Co0Mw1zx8EjcNDAl
	r7Vu071y29dFaItjQ+YjneIY1zoDgmR0XdlEYx9gv4IMY2OnQCvyhGKJeco/IrooXHxQsR11wm6
	0E+oJdz5Gu/5M2OEXwZabyjfJpMYEaP1rk/LaCCTQf+DoC92S9oywJ7Ho8pHEVG8Oat7O8+YFXo
	OSQ
X-Received: by 2002:a17:907:3f96:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c161ea32e98mr929035366b.24.1784125432269;
        Wed, 15 Jul 2026 07:23:52 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 4/4] virtio_console: take a kref in find_port_by_vq() to fix port UAF
Date: Wed, 15 Jul 2026 16:22:43 +0200
Message-ID: <20260715142337.22811-5-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_port_by_vq() returns a raw struct port pointer without taking a
reference on it, unlike find_port_by_devt_in_portdev() which does.
find_port_by_vq()'s only two callers, in_intr() and out_intr(), run
as virtqueue interrupt callbacks, entirely independent of and
possibly concurrently with unplug_port(), which itself runs from a
workqueue when the host sends a VIRTIO_CONSOLE_PORT_REMOVE control
message.

unplug_port() removes the port from portdev->ports under ports_lock,
then later drops its last reference with kref_put(), freeing it via
remove_port(). find_port_by_vq() also walks portdev->ports under
ports_lock, so if it finds the port still on the list, the list
removal, and therefore the eventual kref_put(), has not happened yet,
and taking a reference at that point is always safe. Without doing
so, in_intr()/out_intr() can be left holding a pointer to a port that
unplug_port() frees on another core before they are done using it.

Both triggers are host-controlled as the host decides when to send the
PORT_REMOVE control message and when to kick the port's data vq. So a
malicious backend could race the two on purpose, without any guest side
cooperation. The freed object is a generic kmalloc allocation containing
a wait_queue_head_t, which in_intr()/out_intr() pass to
wake_up_interruptible() after touching the stale pointer.
wake_up_interruptible() invokes a function pointer read out of the
wait queue's entries. If the freed slab slot is reclaimed with
attacker influenced content before that call, then this is an arbitrary
function call primitive rather than just undefined behaviour.

Take a reference in find_port_by_vq() while still holding ports_lock,
matching find_port_by_devt_in_portdev(), and release it in in_intr()
and out_intr() once they are done with the port.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/char/virtio_console.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index faef362dae85..1b7593684ed9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -304,6 +304,11 @@ static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
 	return port;
 }
 
+/*
+ * The port object's reference is incremented now and
+ * it is the caller's responsibility to decrement it
+ */
+
 static struct port *find_port_by_vq(struct ports_device *portdev,
 				    struct virtqueue *vq)
 {
@@ -312,8 +317,10 @@ static struct port *find_port_by_vq(struct ports_device *portdev,
 
 	spin_lock_irqsave(&portdev->ports_lock, flags);
 	list_for_each_entry(port, &portdev->ports, list)
-		if (port->in_vq == vq || port->out_vq == vq)
+		if (port->in_vq == vq || port->out_vq == vq) {
+			kref_get(&port->kref);
 			goto out;
+		}
 	port = NULL;
 out:
 	spin_unlock_irqrestore(&portdev->ports_lock, flags);
@@ -1706,6 +1713,7 @@ static void out_intr(struct virtqueue *vq)
 	}
 
 	wake_up_interruptible(&port->waitqueue);
+	kref_put(&port->kref, remove_port);
 }
 
 static void in_intr(struct virtqueue *vq)
@@ -1723,6 +1731,7 @@ static void in_intr(struct virtqueue *vq)
 	if (!port->portdev) {
 		/* Port is being unplugged, ignore further data. */
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		kref_put(&port->kref, remove_port);
 		return;
 	}
 	port->inbuf = get_inbuf(port);
@@ -1756,6 +1765,8 @@ static void in_intr(struct virtqueue *vq)
 
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
+
+	kref_put(&port->kref, remove_port);
 }
 
 static void control_intr(struct virtqueue *vq)
-- 
2.43.0

