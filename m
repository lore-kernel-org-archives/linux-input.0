Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484238;
	b=2rKCMTw+7TcqoHLuM2+cUz3nlf/Trob1zCmAkKOr3Nug6OcIJdvcVuYdBUgGF05ZsLv5
	 CLvdZO/Dl0i9AMEvn4/Me80sBcnkklizK0dvbvqZoTyCf7753NEDUxIOCnmnXT15+Fb9X
	 JlfoO7nUhfqkkc/DS6jkqz1zYGXh8pv/1Qr36R1PB+YdxwkxoWnWCFvZYG3yF4+bvCYzZ
	 C6CrvjU4vY/r3elWVMadkuVnptxATg/IrmwrUh7ZgFXl22xoEPbCXhLuWpQewjzMFhG/H
	 tkS/+D0WAxLer+78KxPaobX1+B4sXgrwrZDbklz3mbL+MbuE3o67ZCc2yZAv9iGFj3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rOBnyhvWHzx0bjYjQxlKkQMEdsHfPO6Xe5vG3n7bK/E=;
	b=5iXoPYtLKtaKdo30OGJD9tM1WOg0c70FYdWNyRM1xY015WjCqgfsc5GHP4GLosmcXTe2
	 mikR/WeqciuFGK7TrTg0e9mnAN8WkaDBWy1DnkcX3sUVeheKfFPne/USQwxOo4R+sEYam
	 VD9Q0ZQoK1uooy6gykV+0aBBfCWfJD6VmJ82ONLVIexD5vMy8LJW+LvpUwTEj9Q1m/Dzq
	 SFTysUD0DmhUfdVOSkmHa41ZSvgZplbBHwZJiY4pfIwkLKlIKWI9yRzeLeUWrF+rJifXS
	 Fu/9Ls3JDRgSYdgjOLr2HZ9iA8asYzV3iatCTMX0igqC9TWRzoWWVwdcjywV6l1LYJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mX/ikDkj";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B921606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B921606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX/ikDkj
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38644aedba1so6067984eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484238; x=1796089038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOBnyhvWHzx0bjYjQxlKkQMEdsHfPO6Xe5vG3n7bK/E=;
        b=mX/ikDkjsZ1HOZPAznuUIZCNhv0GZfrJRoXYdqpMXu2UcMysrXnf5H1KXTPwTjfRdv
         BCg1ncNhp0sUypoMBRgK69f5VqtMy12kbwAh5NItnkulKkP6Kc3E2qI5i7UZcHLQ1A3p
         g+HZk/qK7uhBYzRWCjzxJuWZo1m3r9Icz79NrSDE+KQ0SkfwgI+bqGfhWGIlJOteUSlA
         3aI/MYUbdFooYumM8bq503yEajdrsUnVi2TsuJsKbhWkL07n+/+BTi+rRfpagTf/UUc+
         pn4834jTGu2H3JNMkNyUCvXgF7SZER+L/UkleeTsAhbLa1xaWJJ3C2Sxw9R3zqJGP5cE
         QOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484238; x=1796089038;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOBnyhvWHzx0bjYjQxlKkQMEdsHfPO6Xe5vG3n7bK/E=;
        b=L0kj3M32r3odWfdUnAT+xNir7NYezDqjCgD7ubhHWJd7lgebD8WWPOmHuDHa1olutv
         vblAIymr+keSFreZRtPYqoVzw5JhrqlXIsvL3hcXU5/h5kRjm6Dtwc1TWwFSxJxu0YEd
         be4esj/Z5W/F7eS6d7QRgaQUfFLzsHIkRxiTIfEW4kf7PoHcWrcc8zxkrYmt1+I6U/4U
         v62pKcN5d0z17R1eONeKKI0d3chcUS4s/YKoDTKaLjONoguMbwADsR64m9lwqUZ33ySH
         QMf4z2c/QdcVnPX5GTiNF20VJo74u4lCd6uDtElviT/ZdNazJvlEGtC/pnutNmhL9JZR
         onJw==
X-Gm-Message-State: APuU4Z8jeheEqd+Fnd/mabRBrfNV1uUzwjAHmTuSFpDMLxDyyHxy70yT
	43Foo4SDtUhtYjCkr4nR4O2Y6HjEJjc8xoWbMGmSKFTINEMe+h0tOwZA
X-Gm-Gg: AZFdTZe7jFL4+QtkhrfRoyaZv0IiB4hkB7dZe62AIhBFnAnPoG02ZiB1mvxLKm3Jo5/
	3eYqg2iwXaHoZXLxitSiKsa4cF+eAoM3BcmPvMDMhUW/gsW9seUw6wXVqKWeQH6jODh3QH0P7BX
	tuagj2BBPGXV+eJyuRDohtx6x4b8s3k6+UOPy1xfTxzw0MdggCdSOmrvpZZHb6oCmum6r5/mCej
	Zpoi4P5fogvf041STBRNak4oyhgc96FAgBi7GF9gQCPgJCe6Gh06qzJgoII4u8FIYvb5DOIeHzg
	f+A8ry4bYQy1/1DOeFSFtz2Q2n6mikv1EQ9IdF5uaWU7qtPX0BuTeGhQqrkqjMG/TQvgHjtSw7N
	H7NXn0pfDHOU8rEXILgDL11dLsv0ttHkIMUOaDsKNCaEUI8gU2zZK49zXGFks1bC34wftFnnrZw
	BVGlwQMa8gIPtoJ7/9trk6RQ5hTTCpRHer89yL2GC1c1MtXiD2NLt17qKA8qsjHQLKbzqXIkr5Q
	HySlYTGLViCljzDYTymfVHuaPXZHoQjQsT1mLJJs4sh9ZsOsovYq53eZRFs/7uWAg0Jw1pDV0i8
	dO9K364K/EjtloZBfTS1SWv49zpXUAMkdZ8JqzCnqo3tWDq/qJOtuS8qSILmHTPY38LGpRho
X-Received: by 2002:a05:7301:488d:b0:366:83dd:46f7 with SMTP id 5a478bee46e88-3856f85220amr14699572eec.17.1795484237555;
        Mon, 23 Nov 2026 17:37:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm38959014eec.15.2026.11.23.17.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:37:16 -0800 (PST)
Date: Mon, 23 Nov 2026 17:37:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jame Jao <jaojame6@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro
 14 2026
Message-ID: <awTqNdGbjttgPGub@google.com>
References: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
 <atJz_OR-rIVb-RDW@google.com>
 <CAN52AYs19_b749avEjT-1ZaNZs6qp+3YyTHJgxRiAJTLyhJedg@mail.gmail.com>
 <ataOD1M2R_6mFJKi@google.com>
 <CAN52AYsVUtLLw3JEzvMSHFJniN7DdYfe8HypVUkPPw_UoHzA9Q@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN52AYsVUtLLw3JEzvMSHFJniN7DdYfe8HypVUkPPw_UoHzA9Q@mail.gmail.com>

On Wed, Oct 21, 2026 at 11:38:45PM -0700, Jame Jao wrote:
> Hi Dmitry,
> 
> Eason is the nickname I commonly use, and my formal name is jao jame.
> The sender and the patch author/sign-off are the same person.

I see. Applied, thank you.

Thanks.

-- 
Dmitry
