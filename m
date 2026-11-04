Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786187;
	b=1pQgU5oU4GvbK0ogkHjD3Z7pOZXuPzPVuy9VbhYJ/EZo0DXXuDkiFalWgigtrBEnzO/E
	 yO8sh2rDePNdSYiLxrXWnPcvt/PrlJj10q0LPW2zjrGFoGemMZRItHFW1K4SRz4S2viYE
	 KmCBkVowAYYGSnHdgQjTt0X1xM9omuVs5CHeD0M139qq+/V8RkI+G4sbsZoxT4U8jFuxl
	 sMuu/vY5z5GvMk8ZBYuIL84eE7j35ez8DXtFv3PJod7517UYIvBKGjZwJkLJLrbfuv62v
	 TCBopql6TX3VlP8H/QMcO8R/7DjO70Dg4poP6vY3rXw7YO1VSy1JXAmXGgjD3INSE1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vRF2IRPDKW7IU9GzlHV0/GWISRE9+PInmvf0t89mBAY=;
	b=gkCDFXtkkIVvR+ndgx090GGaO73L8IZZyc+q5IU+1CR7WOraAaZnn+0fU68apxZqCY6E
	 ZscPXEXvNx2FHn0vOmR9DnSmRlfH2wcGoczWD684fGPB/lavCsiMcNNeS3WZwO3XnZr2Y
	 huIkFEuFgdwD0MpR/jpk5rUleZuAvFkfASpV0jgglBRRjKGndJKqnUPGlayhp5M2OEE2P
	 5G+REmm0MMIZhGFXzMgH6dz3/yxZpKHA3Nipfaz7CS9wXANJwaqCzU3Lyj9ZMP+1tZdRV
	 WQs6AFNmaZ89YoLnDRO0VydLPhaEEa0PbOBfkiVjLmNCHySSR+e7go9k5TLJ5O8HO2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gWZhAgg9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5A606A32C
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E5A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gWZhAgg9
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso562607a12.3
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 01:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786185; cv=none;
        d=google.com; s=arc-20260327;
        b=q1720/yoZK02V3vZCIi35KkJvJx5D4pBfZYASZLlNDE7NwoGDPmQbhhQA3NXJmgn87
         PMxcV9jCsGtX46AlHBDvJISglPtGQkjEOgnkMy3PMXWpYg7IuLcpIy04cOX0eWVW52LQ
         QE+dDyhirLdExbUN10dnlNWOojtmxRtEn7r1T7NPAdboUTqKJEFh/vxmqlZOFTCwk0u5
         Efb1kOdMARn5f92GKOjUZxzXkGjSAc73I1alDvewkiI/YSPOQluxAJ2caCrC23vA/acq
         TuKJKTZFGMW57sbb54YXfS6Dye1qzqgzonyH6ac095xdu225JRMyzzbysI9UlvFOeyeG
         N7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vRF2IRPDKW7IU9GzlHV0/GWISRE9+PInmvf0t89mBAY=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=QiRYK8K2R356bQg77PeeiLqEH3MzFToiGSpoCOpmFsSx+5xNVqYQdI9AHgoByBCzh2
         rxjRfJzEPrxYW612W1QHuzU/h90rfrvNe23wFwslp8zypkUJcKJGHMzSBjb1IKpCGelj
         UlcFqQup5q+b4rAeHhnmaac1kiAWkWBhpVhYBajOK49zuZji5D2UyEum5Qg0nAErttuB
         JoebJuh5RKugy4OxBzUFnlJGoMesq23+eTcZBh/CdVvzq7F0uXSW7CQEgO/Sp60EfKJ0
         OQzuMSLwwr23aFkQQ4HB00QNerd5zC7glVJe+XtwIGUy+oU4CmRQBFy0T3bkO5Q67E3u
         ERvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793786185; x=1794390985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vRF2IRPDKW7IU9GzlHV0/GWISRE9+PInmvf0t89mBAY=;
        b=gWZhAgg9YIDgZnOonSXVa2tZ1hGN+OASVp+1ONCoXUnNkQs077OHpb4z4VM4LYwFKP
         R6Csqs5BBmw9gKruR6j8qPg3ia8pm20lKLdlQMfNK/q9v9dPXdbR1x+WckoqPpsyklvt
         AyEOFpqNSzuN1tp3aEy9YT959YykKjrJv8WoA4Ig91YIVE/qkURqodbAsz+nLaLEeIvU
         h6Xl3NcsHXmI/Y4YHK6zXc1gopt77iJnCN05JO5IHdbDnrsvlpIrA52KWgy+d7bklzGF
         iCydvnDdwy/UG1QT4uLsUZdCkJcojYep8jGV1S0P2LuV2/D/u82cTzgQifTjhtqhJzbw
         YroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786185; x=1794390985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRF2IRPDKW7IU9GzlHV0/GWISRE9+PInmvf0t89mBAY=;
        b=oD0WDd+8bxZoecj2DYJmV73zSh5JDIpeHe+boLbiZ/NF/G5AgsnNBEubhIkWM2/qwl
         CQsnPP12NSfLfQNTtNBykwIrz2bZiCVG+/pnQDYETttx6xWjHicD0tL/68zIq9YCqUH9
         dJcpbEpQ/LIrt55WIEpZUoCShcB81la4CN8czgMSVOesIVrWEejoDWxmdMjUz2sfaki2
         dt9rnsxYheW6LbLsWxkf/dMNBYWaKQyauSNNLJzasMn3oK1DJVRbO0zS9l5AGp+IkDOh
         KBG/45iF71Jd7DqXgigvs9BWLIDaGnpkv+fEactcY2LXU8btvXNW4MKhwDBSY9HO3XJ3
         z1QQ==
X-Gm-Message-State: APuU4Z8dl8Y9wVQdLSNsAjL5MSfoC+mfINedKCBEHlPjjDpkHDv59m4m
	fYO/dC2NUji+h4cdSzj/H2jImcCe/QFeQ9lJHKo5eyC4CDt3FGQToxGbxYrif/tQE7GTU+c5aCb
	2rxdNzhsY7rFDVCH10nQnIX/72xSQ4Sy4rv9ePg+n
X-Gm-Gg: AYBFou37tOVy9dwnMssckOWc4qVNLsiHTnHq9fVO+qhk6Y5v86vobx060E6mn9pfLI0
	R66ly+1RxFrVD+OBaCPApKwpZo/qHPZz7SOtXy9dV4uwcg1tnTMbGbFkKaTn3qupyeZRfW9W1nH
	5JKRFQcJr4B6o1Wf2VYT3Bwjgz8EF613q2t1isqycMZ1UUqgl9Gvdvgj6PzyHle1ZhkmkWZrUrp
	l5k5/b/x5nRhAeO0YAIPgzB8y7iNlqV1GtUOIXlUvwF9zZtnmmXzQm+mJE5BhC/MaMGmLAShYcB
	g8kUpxYe2cHPQmWHBEwsiE8Dh5m5GwDVv/H0yr9Udm+A3fSZ50rBd+YtCz0Yf/mNW1k7JIxU4qH
	ifdQVJTwDtiIj3rbdr5p0JvKPxoKCMXznZTxNw6uAc15xpp9nyXopxpPmsSffABjNFZmUIAfUkm
	VIZqPf2j7QN3mH
X-Received: by 2002:a05:6402:c50c:20b0:6b3:f05e:fd79 with SMTP id
 4fb4d7f45d1cf-6b4d497e5f9mr8204762a12.21.1793786184593; Wed, 04 Nov 2026
 01:56:24 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
 <20261022-evdev_syndropped_fix-v1-1-b5400740e1f7@google.com> <aulT9-9OU5VE_PpL@google.com>
In-Reply-To: <aulT9-9OU5VE_PpL@google.com>
From: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@google.com>
Date: Wed, 4 Nov 2026 10:56:12 +0100
X-Gm-Features: AclHuK8jBOCIKnQpO3m0aaz7IJblEPHIyIkKJZfCtJmy3_bgKhSECD37vY3wjso
Message-ID: <CACF_fqmxJCQCnDXadU2MgEqkrabwNLkMy_ZQ2pdxb+3bfNsu3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: evdev: Always terminate SYN_DROPPED with SYN_REPORT
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Nov 3, 2026 at 4:33=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Kornel,
>
> On Thu, Oct 22, 2026 at 01:39:12PM +0000, Kornel Dul=C4=99ba wrote:
> > Per Documentation/input/event-codes.rst, on SYN_DROPPED:
> > "Client should ignore all events up to and including next SYN_REPORT
> > event and query the device (using EVIOCG* ioctls) to obtain its
> > current state."
> >
> > Currently, __evdev_queue_syn_dropped() queues a standalone SYN_DROPPED
> > event without a terminating SYN_REPORT. This causes two issues:
> >
> > 1. The queued SYN_DROPPED event remains unreadable until the next
> >    hardware event frame arrives and finishes with SYN_REPORT.
> > 2. When the next hardware event frame arrives, SYN_DROPPED is prepended
> >    to it in the same packet. Compliant userspace clients then discard
> >    the entire hardware event frame up to its SYN_REPORT.
> >
> > This was discovered on an Android system with a gpio-keys backed device=
:
> > 1. gpio_keys_open() reports the initial state on open().
> > 2. Android follows open() with EVIOCSCLOCKID.
> > 3. This creates an unterminated SYN_DROPPED, causing the subsequent
> >    event to be discarded by userspace.
> >
> > Fix this by appending SYN_REPORT after SYN_DROPPED in
> > __evdev_queue_syn_dropped() and updating client->packet_head
> > accordingly.
>
> I do not think that injecting synthetic SYN_REPORT is a good idea: we do
> not know at what point the clock change will arrive, it may arrive in a
> middle of transmitting a packet, and if we discard only half of such
> packet it will result in incomplete state being presented as complete
> one.

I don't think it's possible to flush the queue in the middle of
receiving a packet from the input framework. The only callback evdev
implements for parsing incoming packets is "events," which I believe
is called only for full, SYN_REPORT-terminated frames.

The only possible scenario for flushing a partial packet is when
userspace has read a part of a packet from the queue. In such a
situation, userspace will only see a single SYN_REPORT, though:

1. A full packet is written; userspace might have already read a part
of it. Let's say that the remaining part is: [foo, bar, SYN_REPORT].
2. An ioctl to change the clock is received. The queue is flushed and
replaced with: [SYN_DROPPED, SYN_REPORT].
3. Userspace now sees the part of the packet it managed to read, plus
the [SYN_DROPPED, SYN_REPORT].

> Compliant userspace should not only discard events until the next
> SYN_REPORT, but also query state via EVIOCG* to reconstruct full
> picture. Is it not happening?

Heh, good point. In my case, userspace called EVIOCGKEY(0) and
EVIOCGSW(0), but it didn't parse the results correctly. I actually
fixed that too, but for some reason, I didn't realize that it meant
the kernel patches are no longer needed.
I'm not sure if this patch is relevant anymore; sorry for the noise.
BTW, the second patch in this series is only relevant if this one is
applied. Because of that, I didn't respond to your comments there.
