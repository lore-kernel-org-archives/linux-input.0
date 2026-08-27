Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B3410D0F
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822600; cv=none; b=b+yoOv3h/5rMVBz6b1AgNM0T01K1OOORk7lTCwPb/bPBha1FS7COZQsw4Qn+wB36GwvhPTxOsJaOU0Qx4wnp8KhKWXACGdatDNBq29UeluZ76pq9Rf1LIBDoxdcFiNfOTCmvGumFHDaUey6PgRd8W4+Da8UGw2Zgt+XZr/9MF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822600; c=relaxed/simple;
	bh=pilzqgLX23vrgU8x1OrQeeuvR+C3KBcsvDYv0GU7JNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUR1xUoSN6p46/fckWwhkPWWIXt80u/Z+rXwr0l5yfLTq7VIfs/9vGR0q3VMWQ9ldrdpCvYFIFyf80b3EKbHFv0RX3xZSiakDBsLoe/uaYavQ30nbwWa2tpIFYPr3/s4t3YaQbEPQlFQE6AUOvZpfv19XHmdniJE1B1+nPtcElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+VeMma7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+VeMma7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1997528a91.3
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787822596; x=1788427396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaA1NG09mAC26Uk+RbGvv99dkflUecBsEoDtXvZSg1g=;
        b=d+VeMma7DOFPbV6c8HI/j0lD2Gqq6H1sYrechKiHBrPkRzMQ+HWEP7v43q39LCnFcV
         4wRcbQIOCX+/f3C/ptkpSKCXcb4GJoYEJIqVi+Yx1YM6FtyoTv+BFYtonlk0PVXCGPSV
         aPWm8zZn42fKiYV8QNv+d7yOdCD6Pj4Z1jOwfwyi7y9ddr6fruJGVvg0xBW/o1iWXHL/
         ISvavpbGdK2QiHtJBTV5eklEmsGa78nQEY1uaMBkCYoMgjpVgo1WTzku8Nbn1AkJZqzR
         7WHL2CqaOE3bIQ4tK6VBJrYfk9DK5sJu0b+Rp37hcHCkrYwNr7pfjT79hv6qTNsPkbZp
         +j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822596; x=1788427396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uaA1NG09mAC26Uk+RbGvv99dkflUecBsEoDtXvZSg1g=;
        b=eEmbFXLk0/8gEPQs+YQiL9ZI+lQfRFmPBeXph5a41+rVEup9DkmjOL73eEBUS3+0fu
         O+v/NC64J34GenAHrfU3TdN85VVljkDc3lXGXxA/TAT0JvhEAmv6517w9PLiF3x2kuRg
         ceYGozV9DD8xpWLChQFKNk4vNsF7WrEYBRvYe1K1/zx9bDVtqCxFfFmh3vgkDGOEsDSi
         kOY/16IK1LJUGaPQTkb/LdHvodkqwMKOyiQo/K+ysFH9jouOZxKE6ZihPUU8arv6qv/I
         O+w21qzBiuXsjCQzbb+8wi32AIcy9otR5PDqbx4kJc6fvws3aynBcHX8nJtTUe3TXIcZ
         d4JQ==
X-Gm-Message-State: AFuF++nC72Dua88lDZ4dDCQf61rEzAAJsFeaUCTbMLjyMKIUn4ywiUks
	+FLr+8qpy/fPDdh3TvsIkFEviJlXczoDXmXvYUW3XEZdydaCCKOSrWS7
X-Gm-Gg: AR+sD10yIn0V+IMvsKTLOStF1/79fw6OJo2vSMXrCP4wT8zIcZlnUgzaJejmoTwYdtj
	aUAMKz42emnBiYwrk12DcEEy4z+jrmdzxKEcTKPv+0XLjDmbPavLuGuvCfZjPBvFf55HBYrmzN6
	KTvf69MxWMuCpsKjIA2ULc8MZMppb3o9CE1gtSZtUDVXHcuFrvV50A5bLbx8DXGCVLk3xrq9aUs
	Txqq3K3nd7SfCFS7OjkEpSq6oMasmlHrfQ/FVq+WcaObIr8HI/+5R/oQ6aS56FYoyqWb0XoT9zg
	SRl0vUuzHhgK5t4N3lG9tl0vp/YW+YbhQmqvtYew2FW2TWDB+c4uYQ0XjhNIcJ3U/wOqwrhhW7t
	GvDxV8dS+duRUEdgSKilbuwllsVcSs/7gA89brJGbS2PqcEPtzU05VHgIStPucBjXVs4sEHpfsb
	qGITWVyoWmbhnV0Xn0tp2xSipTPZhkbOVLlFwnfsGJLa/DZXnWiqI3Ipwyrgu5o4AMrw==
X-Received: by 2002:a17:90b:164b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-3966cdf6813mr25481388a91.0.1787822595919;
        Thu, 27 Aug 2026 02:23:15 -0700 (PDT)
Received: from Default ([2409:40f4:1015:7531:12c9:ad3b:96d3:4379])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905c18bsm16037789c88.14.2026.08.27.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:23:15 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: KASAN: slab-use-after-free Read in roccat_open
Date: Thu, 27 Aug 2026 14:53:01 +0530
Message-ID: <20260827092301.19883-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a8fd9c8.50659fcc.60cd.000e.GAE@google.com>
References: <6a8fd9c8.50659fcc.60cd.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream 903c1cf6dff9

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..505844890ed3 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -236,6 +236,7 @@ static int roccat_release(struct inode *inode, struct file *file)
                        hid_hw_close(device->hid);
                } else {
                        roccat_free_device(device);
+                       devices[minor] = NULL;
                }
        }
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 505844890ed3..220666bdd13d 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -370,8 +370,11 @@ void roccat_disconnect(int minor)
 
        mutex_lock(&devices_lock);
        device = devices[minor];
+       if (!device) {
+               mutex_unlock(&devices_lock);
+               return;
+       }
        mutex_unlock(&devices_lock);
-
        device->exist = 0; /* TODO exist maybe not needed */
 
        device_destroy(device->dev->class, MKDEV(roccat_major, minor));
