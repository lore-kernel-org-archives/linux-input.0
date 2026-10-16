Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706C472F97
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145748; cv=pass; b=doW+kRd3W7BZt2E4wFenYmYedJiXIpKAOmQqqCPAasyTxJd8jcGMSU8Xx1eHye1+6eiyQVVR3LUBV9xUs8fZHL/5923MX7ZqkHLwnAyKIP6bWhP2fac8xFNIc7/I8ovcL4w4LCJCHc6GLfuC3WLr7oz6fdIZkGjhFTCyanYM1sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145748; c=relaxed/simple;
	bh=m+EcWpb5wUHZA4l/YIOJiWupQfQ1DWz+cRbbdR81dXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p38MzgsfxiSxhtFeOBgmRIaNdFRwgiMhpFOuBQ048ZkR8mgNr76dTPy8LZqzx1Juf2vlXPgAfMBiZIj3RMit2H2uU94XB/A375Xqj3RAGYgODc//ST+hjciehgE0JFR3EpUhQzKtKlJ49ecuvXS3509bRZmdcEOmn03kBEj5ZAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddnIV5G+; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddnIV5G+"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-70059e4dab6so927672eaf.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 03:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792145746; cv=none;
        d=google.com; s=arc-20260327;
        b=VrDdkskQZ5j6aiHtP0CqShi2BLM+pJvykE0Q++GUmvOb2xMoveP1SFNgj2Y+ssPce7
         0iz2qFA0EUK77NS4r73AuFR0Eqsa2hh7wDmMeWB26sPB4iJZ/SVxDVA5G8FrkD0aBO7h
         VqDcvOSLljFU5+vP6aBX1husDtzl8QfBqtW3lXR1Ev+aBAXSfp7YZNfJSNHQG6DVmG7I
         ErU0+veONevOnxP4HT5hUISniAUiazcWUdJdCgTlmb7/ZVObHNWS6GN9DpvnDssTNr6X
         ngh39N+Ns3AjvdIbG4NmzAhRuSH2pQzTk9S0SS5ALXXMEETtZjL5MBLZD/sbq/2I89JB
         eczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ixHThCS1DziF7jaaEn+F+nAUwwMRbRLnCSspBqixcY0=;
        fh=/PZT95YCvef6CfdnQfhr0GF7q9p/kaN/fhu3uWrwGiM=;
        b=NsHpdFQ/7iE9hNsCGZgZjE91gzKPFiWaAV0bmV0wOavrMY+eYL93Jh8mcMpMzB8L0/
         qyB7FRiS6CehZ7GNUYxH6oXmdAx0O1y22h32CXP1NViiSOryuIoPALnE7SQlxbryTy1f
         dXzroLKB6kZC1BXpM/bxfVPKG9dXMUorPhYgMMKdOduqeoZpZ0y/geJxCG4iQyptwaNl
         GM7m8PhsF/fcHB8aotukvDQrvTeXRfW+k2jVQ5FaAWshprIYPZa28jYglOyjSE5ykP0P
         1sxlGWZvaAp9qZ0YykHEP8Wgb8VcHckBf5v7+ZcUQLdxA7CYbiUL2NrXYqLy5CzEKpZh
         5qQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145746; x=1792750546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixHThCS1DziF7jaaEn+F+nAUwwMRbRLnCSspBqixcY0=;
        b=ddnIV5G+MPUuwl28rB68ANwYcwzAr7ZMB9Y4bpeNDcP37X6s5Ko+mbFVUA+LlPVhAl
         gng60D798KVW1mCeyC8PiMiVgLXZH0IvBWhqc5O+6Jbi82wfjJZ69uSwbb+tJD2bbqth
         DgzjnQEUVy6ZihuNUdjyaphal9JXOdrfq6vzMRwlJvMfH5YD8Xar8ecBdvnfNjOVZ96L
         wNgRPv6PQz4Sajx5JE9KALU9/UyyZhrlUUM1RySIug0vH+EsfXWj2Kj/O87CzOTBa6D6
         2ipOGU+2LRk3DUIe9uyd7YG1R1lxNpbIYx/Au4/SvRQNBXD14pSAAC6/ZKAlaJ5zD3Ar
         VKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145746; x=1792750546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixHThCS1DziF7jaaEn+F+nAUwwMRbRLnCSspBqixcY0=;
        b=D0yAJeyLYaY6+dvNDUDh788mibhAtp1Zs6hxj/FMYMZ/Ffbw/TbYeadjiPNZNbYFrI
         zfwzBAonwT9Gv2gW3Ae9uBCWefY2Ly+klA4mpSWHbL5+pQY0FBFfcFp8wyJea8LIRgKO
         OfliXYfpO0eHJiy2voC6n3cg2sxzJVJp/QCy7+RW89DY0+hck1KnucXLUIDv5hdMlEAm
         K822Ty6qUxL5LAFqg6zK3VMHcIYr653z5uH24ySz5HXhijhJIa7O5lYWJrOXOiOGlPCR
         Aszb1Uup7uSrG2vIEon5cb2525NFimNMAdqv/9pXpeXenkOXjfA7vk7/mE49FUAQ70w8
         uUAw==
X-Forwarded-Encrypted: i=1; AKwUvBzgiQPfakx13BCrQF/z2rA2saxFAWYTvfBIZoUGUYUYyk1jfQVlmWb7ukIASvpHJJlcoAnlfwRvEVbD5Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYINzt6YA6Xt8jUXe7is2kyg2J9gJo82K0sP65OCjLeuUoqbalgB
	kIu6jk/jNbLoU4TMnEnm3+JVUugJZWYiUXjcQtvMykt+mFB62Wy/BKf9GKeLSTZGLXdnqsf9ZZ8
	/UZIlcq2ich3VQEijLj6v2k/lvHGZGZ0=
X-Gm-Gg: AYBFou1wCGYtTyloGGfOYPMZELYY5zzKOZQXEE0IvB+aeS7nR+LwTvQcLUdo6a+LmlE
	gbUysh2+UGdm1sKdt2RicYvRJzT+eiuyywzoyxA7VLBOurmO3yCe6nPes8NoGzgECye2yJDQK6Y
	BFgU2v+PFZ0cmJ7HbR42lRGC6ZZxi4sSEAZH/IxIX4rocftvBTiyfPCydFGnQDajdvzgFwRJdA9
	aAywJDBb6RYS/U2xJtmJAhCPP5IIzdUKTIItVVDIbOgHntkYJd2DIJ2a5eDHlgLqnX3NiEvWO4X
	BPRCkO7Rxg8cSie1XvpcisKU8ZIu5lpUFql2MRMW//zE1JLhsNla3tpCwj+fSnq+DyZoKxdr4Bd
	0JLrfFZFAKGuuNO04fC/QR+DBojbbrHMRjhEp3I+Xyg==
X-Received: by 2002:a05:6820:1382:b0:702:af73:be5e with SMTP id
 006d021491bc7-702af73bee0mr327002eaf.37.1792145745743; Fri, 16 Oct 2026
 03:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com> <65584p23-91oo-r3o9-84po-7r7679278pn8@xreary.bet>
In-Reply-To: <65584p23-91oo-r3o9-84po-7r7679278pn8@xreary.bet>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 16 Oct 2026 15:15:33 +0500
X-Gm-Features: AclHuK_jxLyvBoyWgfXad4Q9KbjUS7aENODGbRm3o0iIJWM09iFwu7vz4AngPWA
Message-ID: <CABXGCsNRqYPtKFMtmcREH+Dti_wSRCBb9iCSEg86zVBJO5acyA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] the Topping M62's vendor controls, on the
 component framework
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, tiwai@suse.de, tiwai@suse.com, perex@perex.cz, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 2:50=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> Acked-by: Jiri Kosina <jkosina@suse.com>
>
> Takashi, will you take the whole lot through alsa tree?
>

Thank you, Jiri.

Takashi, please hold off on v8: v9 goes out tomorrow and replaces it.
Its 1/8 is v8's 1/2 unchanged and carries Jiri's ack. Its 2/8 is v8's
2/2 with changes a user would see:

  - v8 treats the M62's Mobile Mode as Pro Audio Mode and writes, at
    the first bind, two output selectors that Mobile Mode does not
    have; v9 reads the mode from bcdDevice;
  - in v8 an input gain the card has not reported reads 0, which
    alsactl stores and writes back at the next connect, muting AUX, BT
    and OTG IN; v9 writes every input gain at the first bind;
  - "Mic-1" and "Mic-2" become "Mic1" and "Mic2", as every other
    control name in the tree has it and as the M62's UCM profile
    already uses them.

The other six add the E2x2 OTG, the M62's battery level and port power
settings, and both cards' MUTEs. Two of them, 3/8 and 5/8, are HID, so
they will need your look as well, Jiri.

--=20
Thanks,
Mikhail.
