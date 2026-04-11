Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA141A00F0
	for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881393; cv=none; b=IQ3b+/Ybik9/TMgukqNJVremAH9ZBNbsKFdHwIXZ/6t4frOMhf91G7BaEylAxf216GjHT5J1r0wb7wxVHSPhBJCkhRFphw2kkn87MJs9ohNTur1XBGchYE058zWXOaqOyIQR40GuiApXvHUsHflw7+9jh4iJpg2HJlfSLxE4GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881393; c=relaxed/simple;
	bh=6+N5OP74MVT2ebDPyia5u/QFro2yee+0UByj+Lhzoks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NsvyemRTUXa2j1CSbuwmyRoWRCwH+1xW3OUTFFvKVlGfjfV674gfRao2FxXtRwi5WQ2blbodIXTOKAJrKS3Fyu4+HxB9NHYD2s1ZtOeZXLrmZccCweGwyJvOHrmTgOWwCCJDrUW8Xwa6X8PuQExVONy2CiXJSU7kv6p/mBeIqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/mwrwzM; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/mwrwzM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2938978eec.0
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775881391; x=1776486191; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTvd3kTcIMZ+M8sqxkrLIFrEyvSYsEPu/y2oCWOMg48=;
        b=B/mwrwzM72b7OJ4iPJyCA/U3TGIhsIMYenm56Gnz8JGR64OnzAR6d1eLCNtuzuJcF8
         SZuF77Elt0OyFnMx8k5QW8j5WFUODFLUUKUZr3gcOTiaJ4o2Y31iXJYXYjRqytODzHRg
         CH2u+nWkDXHXb80Y5Z/Riiyrm0ZxFCQpds6YgQD1erkueniyDJ1bP6VX01b1PBc3WlMc
         DVcZS0OZP+GwG6tojNCWY7khSBf4iOpoPCVJRtIzbj0x5S5p/OhcjQQK17JFhue9cPQg
         wSMLYGDu8fldIxc9EhCpMPYCKe+yXMxv8HYXJaHlPcirAtkMMYS+Zf9ac3j/6JLwUbnI
         UujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775881391; x=1776486191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTvd3kTcIMZ+M8sqxkrLIFrEyvSYsEPu/y2oCWOMg48=;
        b=YRbXU6uHz7p6y52Z2ncqskBwARDsdTx7I34IXrgx/7mvZQ1YaJvp2v3RQfXMDyM2jj
         lVD9TcAz5skDjK5ZLGhL3HienPJgiM8ptDRXmgodOSFMvwgwqWKBC91KpKCOz3RKqnqm
         XkMFZ9XOb2OVmkfk9KtFG9cE2Iae7N5y/PepG7wP7kDhsa5WQvCQD1fvvNgs76R9XV+8
         w0Dc4x8VH4auiksCA2BC1cOXcyeLjt6lbDT2YmkeNzA1f3Xt5iA1Mb2mxFx0t9TxutUj
         ReyHwKhLdOghpsH1VR0nBzAwlwmTbAOwWfUZXpO6QguozJ60JGkRFDzAyGchlw8aKBgr
         aLhg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjD4a5K+w6Yc1bkYoUpdmUl5+h/HeXbij6a49dUBmhm/U905vXP+N5XtYVzG0oLiUOM2acWm/XNazvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyKrgMQWXN/05IeIteawS07vadLjjF8rUV1SPtudg1w7RKs4J
	Pd16nKqP5rPra4YrJ+r3XHtPTyk92j3ONo2iufF9+wLvCnef0hpAp+BW
X-Gm-Gg: AeBDieu6a2lEwKUkOaf+defdOx0sW8Fzt0sty02V7VhxsJ1L9+Su4egrSOHxqqVmdD1
	z8o+w1iD14QQ/4h0QYeL5kC89UJalFEIvSDlzHOYvBCGyZiUOKICr1XilmvvjYSe3ZvjTJZ735d
	SORLwLYsSh7iGMUlOF+gfZ2zi0qG/fF3FGcfJkUEPoP1tjUDrFTSdyqCCtahSrP7RvGPIuC9Y7z
	HW28+387RLpz4BXYvrbL61TMjfJNC13+cb9NA4fqh8MuZMYGE6BOFMVoMm/pQnTOuqo2VLthSLD
	pq6gyR4TxEM1gyDY6uxPYqubHCKYDLCgP/rUpfIZokL7Whi/6xLhRGpQz2N8RdfxsyayL+n8L0c
	aMiwQ5k1gdsAGemMpFjSGYkqI/z2dLpSXuIGIw9yz7I85fjeeylWqZz7K+d7kJLBI64NKFXOoJF
	ZuE9dqeJtjN2BtdbzGO9SrbZIx4m4D1KohqG+t34GbDUhloGQyVoZwrm9CkzPFeOU=
X-Received: by 2002:a05:7300:fb88:b0:2cb:7663:322a with SMTP id 5a478bee46e88-2d587d83e1emr3371174eec.13.1775881390527;
        Fri, 10 Apr 2026 21:23:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:39ea:e04e:4043:56c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5630ac330sm7112743eec.29.2026.04.10.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 21:23:09 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:23:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.0-rc7
Message-ID: <adnMg9E_ZAjxcv1k@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc7

to receive updates for the input subsystem. You will get 2 fixes for
force feedback handling in uinput driver:

- a fix for circular locking dependency in uinput

- a fix for potential corruption of uinput event queue

Changelog:
---------

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Mikhail Gavrilov (1):
      Input: uinput - fix circular locking dependency with ff-core

Diffstat:
--------

 drivers/input/misc/uinput.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
