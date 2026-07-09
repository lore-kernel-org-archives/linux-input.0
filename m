Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108E2F0C79
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570735; cv=none; b=peTfxROLSMRmRQUKky0RwVuLAg3+czcSAAh9agM7QTXL7usx3x27dzqIhkCkuPIPOZtBLbLWdOjftWfp1ZlEjtEAuNX2iFd7Lz+5C82CaujcE1nm58V3mqIu5SstNrIy4uK+HhknMad5uva61miM6JvPz7bCUZNy2vAUMESU9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570735; c=relaxed/simple;
	bh=IILXyeTLIo8lfw6LFeeHdENWRoNcmpOE4JfBK/1Xe4s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GwolOy1hfC/ysCHkGkbdF/sT3egsORCf+nu59enq3T6nzi93ZYE3Lx9RZsSLcsOjS6g8rHumG0TiJUyG3qls/9fn1wKO4s7kh3v6REZpqvWE6QVO/NHij1sOqVVF8TLBxVgLzvcI3A24RYi/ByUN6+dwUfQf234WmRukozyq6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAHEPvPZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAHEPvPZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso1194810a91.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783570734; x=1784175534; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYQ0kIRnKWVNRjOvudMESd414CivUKbHtSnEwlfkZXk=;
        b=oAHEPvPZLJZq5VkBlNCa6nnJx4ihiD15tET/AXFAnlQ6SjEGdMysfA0bkA2oDge+n2
         sYVu5PghLRRRLZJGfdR+Ckz8kw0O9bNbwh6DA+VApzJjGsMMy9GxFZCKGNPtxLHJkQVJ
         /q7aZeX60+BVdqdav2QnazorjPdL3G87x/Vtzx6P/eAbjrmWP1qq5bWyf3RWDeizMLQD
         RirGwZpMdsJr1oV3lUS+aVSPrpIgY+kDqRWtqUDoelm3MQJasNMlFZdCsP7lf+Lp1A3u
         878tLlzq/x1qfaup5AZen4j6vXoYoD5FuCjVVtEw4yTTJf20g3nM4WGFUZubxLCQp+1R
         9WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570734; x=1784175534;
        h=content-disposition:content-type:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYQ0kIRnKWVNRjOvudMESd414CivUKbHtSnEwlfkZXk=;
        b=Cz5elM2pBwZPvjwg2ZYtv0pmDoAqlnWnvwK3/3bpsZypGy5v1oPm5xkTUSMhhnHObv
         iIOviJpLRDy3GkGvF5HjVkdzkBWv5RSQrt4wBDYckHsimtykzGnJESWbyGZQoZMO5r3F
         G695xBhtK5odZ6aEIVkdViIGE+6Rd3UNXjGVIqrgOMEY7+dJc6Jq+7sbUI0vHpjoVeoO
         KzZ4Vj9smkAVOEJztHcahmyH+wpxcPg6Eu2Iamyzy6a9qXVt10beS8Q6z3Mf+fLxS8nc
         GRejoxo2vPdqfo0S0yZwZdvYSkuq6Vec70N2xRn9ABj3JQAgXMwn7QEgX135mSmzfcK4
         a1vA==
X-Gm-Message-State: AOJu0YxAlq8yx1IEzGG5IpXIyOwXq4AIvyCc//6tnGCrvRzABA8K/Zeu
	b/hnzTnmPfrR1yfUUD7fb/VDAxDduHo508HOk3JyRynajONuW8hyDEBe
X-Gm-Gg: AfdE7cmIk1wjWoqGO/olknKuH8Lzm4LFJMjVQbS3qYD7Y9oUsZ4j6OJI0n0/CrAemdF
	1i2GF34O2nezJJo7+m/3lJauwfZPdJpseYxtJli4ov0ytOAtk0VzdOFKHEP2xNhXWHyRa38Ptcc
	tqvBEGsqeG24pArl+vmcCqDHA5V3Tj8AOlpCzw5e495/2zuElAo4gtalp9p3hnNATsS54E9NGS9
	qTlR1bGIG7gPhwID1DGuJ02hWkJnDauyIE56ohPX6PvWpm2TeFC9B8hTed+JHx3ZiimpqExDULV
	Np7wa2Wd5Cc7Y7xPo3V3ffK4yhnY6meXPzZywX6mQxa5BVir2/Tfty6n6on8Vs9J86usuPJ5fFr
	0rBg4DRsnCPyK6FMe4UA5ToE0RJ0sQ3GCkLoIGscSOetLWSvcPuXitxw73znm79OCrDrLLYptnD
	TdmA+JOScrlp/4lKthL+HvE+ibemZxqPmYRVmB2i4JyqAP1Jn3+9K2Pzehzu1+DMlT
X-Received: by 2002:a17:90a:e705:b0:387:e0cb:7f0 with SMTP id 98e67ed59e1d1-3894249b65bmr5736730a91.36.1783570734088;
        Wed, 08 Jul 2026 21:18:54 -0700 (PDT)
Received: from thesun (222-154-149-34-fibre.sparkbb.co.nz. [222.154.149.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm8062849eec.26.2026.07.08.21.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:18:53 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:18:49 +1200
From: Ashton Warner <drflamemontgomery@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: joydev - replace ev_match boolean with goto for early
 exit
Message-ID: <ak8hKSa9HNYPoOZZ@thesun>
Mail-Followup-To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The joydev_dev_is_absolute_mouse runs unnecessary Event type checks to
determine whether a joydev device is an absolute mouse. Change ev_match
to a goto statement to exit early.

Signed-off-by: Ashton Warner <drflamemontgomery@gmail.com>
---
 drivers/input/joydev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd8a7c1..a726ba0be05b 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -819,7 +819,6 @@ static bool joydev_dev_is_blacklisted(struct input_dev *dev)
 static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
 {
 	DECLARE_BITMAP(jd_scratch, KEY_CNT);
-	bool ev_match = false;
 
 	BUILD_BUG_ON(ABS_CNT > KEY_CNT || EV_CNT > KEY_CNT);
 
@@ -855,20 +854,21 @@ static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
 	__set_bit(EV_KEY, jd_scratch);
 	__set_bit(EV_SYN, jd_scratch);
 	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
-		ev_match = true;
+		goto ev_match_pass;
 
 	/* HP ILO2, AMI BMC firmware */
 	__set_bit(EV_MSC, jd_scratch);
 	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
-		ev_match = true;
+		goto ev_match_pass;
 
 	/* VMware Virtual USB Mouse, QEMU USB Tablet, ATEN BMC firmware */
 	__set_bit(EV_REL, jd_scratch);
 	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
-		ev_match = true;
+		goto ev_match_pass;
 
-	if (!ev_match)
-		return false;
+	return false;
+
+ev_match_pass:
 
 	bitmap_zero(jd_scratch, ABS_CNT);
 	__set_bit(ABS_X, jd_scratch);
-- 
2.55.0

