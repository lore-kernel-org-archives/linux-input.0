Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03682D7DD4
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106685; cv=pass; b=oP4mJrT2zj/VarKCeex6goa6vnCoK7LJzPiSWReFYXglRRQ1994ZNLRvbLU6pSqQ06dHXWSc8oLMteBFXYboMbZlTEY8tMT8P4Xmjd+FKqA8CJrnab04tEQ6W67sHJeU+tZBQyp2sPkijrvmSSuLBCQLyuVqMheMGLG5K9iQixU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106685; c=relaxed/simple;
	bh=hYFb+CHAPoD+FxG1b0ogsBVr7QuNFxqc1woQT268nfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHeQf0YVD6aYn7NRzG7s9I0QnNbgx332/o5+dyNj8oNGGdnRrNzF5Mo4s76rxqGAMLx9lErAenOLS5d616m8yFhnc5Stk7nyq3yh9VsjpXv5fhBFDxM25qDDJ0wKGrlOBa/9tTVHtGJf1xITPtUBToC6Sw7ldr/3eX7S3ohC8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4aEi+oo; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4aEi+oo"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1443780c4so2568649e87.0
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 18:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773106682; cv=none;
        d=google.com; s=arc-20240605;
        b=YsibQiTc83QgGM+F0aCKJizwysKo4+1LShYjYoT5cSDTvOLXWO5HlFDZWy+EvREqJv
         i5lnRsL6a8W1neHFDuGqRHnuOh1+yBLDpTrMzmcNjB8JgFTnaQItbVY9+n8XeipzT4FX
         ZqvQZoocZDut21xUsHmXgGwhygGzoHd06l8ZKtaPOxBsZBfnr8fftl/CL+EkXjXklGRL
         cza37tfQCZbbefGVXI68gXkvy5LD037R2MlsCkdHU8Bn6PyCRumOH2wPMPCiN6YwdoQP
         2sQ5o9C+2LsVbrhYRwsHpqGL8xeKxZibGU5jR3apj2ZrBqud0uvuOK3iBZWl10g/pWZS
         3c+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5JD0I3h+Bg6710KUeP09U+MH0kWId3jo7xnuY4+fPZk=;
        fh=H+m15gsoSXaa4880uXSuBSY8e8S6gJryxSzwElRTWPc=;
        b=Y4hVTWw3s8Fa9cyHa9/j9MEzqSXR2NZ3859hOO+AXdpUpCEz3PglwiIGLbhyNtOXnW
         jV5a5rR8FeI4cvo0n5EJupnjDY810pzgFxIsqPmOrc3BkExcSo5l88VdwiOLye3zOZU1
         azUhTmU7c+qdBIhv7HqmmA/5dMjyuvG444awdo/HNXVJGm7ELuWxGoPtNQ1N+4njwul9
         KwtBm7fHSSzkUWW9qgxTv4dBlXYl2vM8kSUm8g5GxNAi+2e2/ORpCxHJQ1kcdtofmIeB
         6ASwpZFt1Qae1tY4cs+4MNbacYP3pMKs/gexX19UvGX72LfeuXZ+gxS5vs6OY4SeV3im
         zprA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773106682; x=1773711482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JD0I3h+Bg6710KUeP09U+MH0kWId3jo7xnuY4+fPZk=;
        b=g4aEi+oox/IZ4wgYJwBPu4j2bwQdlaV3Dxu26cJBM+bQ7FtnKBxZSVJjMbXYqwZCUK
         XBdV9QlSiTgD0D7zk+k6HdhlgB0Dk42lvcH5NJPImRUFr56cHZnH7lPz8iGPRN43hTQA
         7QQTVEyUm7nPHOta9ZIPvKLvSQ/bwydjHyQgqJ1dsCid/pUnSnbgwqZdBu834QwRRW3l
         4TzDwaR3ypktosXCk3JWmNVGiIiyDTeGI5gDsnlLm3Icn8dSja4RcBXQIBewp6EumuI0
         QRAaMRAMEPBe9D1JsXkFDPBYWGEIx+F12iMZPAcXJtxBjMHXcmLTinFm2NOVi9jYNttd
         mhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106682; x=1773711482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JD0I3h+Bg6710KUeP09U+MH0kWId3jo7xnuY4+fPZk=;
        b=arsToc87e51D9vn7Ql9MIqQ/CJtyPFXrjupwmUbDJwZlZXszUjAvoI55Q+BjKcH6ED
         57kARtmhGvx/XKRe4x8epmv0SVmVqrefyEyPLT4D+pEdzuGRWb9jVUTd6Doe56muTVs3
         cVeM5p5AD5JRenDOnL0b6pOvJoI8ZzjZDhNfoO5/hLJT56JlnPJUTO9qjKLkAD9ICvyY
         1FOyQj2IyChbHPcgxke+jinG+XClfWa9GATkc2dEKOmzDTfLFT4qbfhUURne1RDVo8vr
         KBg2yITQLvpIsQyWFSuUpJJs3CwJ+q/9eMf5hkGkG5qSeAfX0wIDp1FuofpyhZIGmmEw
         x+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXnJP/2sm1t6UuJWNa3+iL5bz0xiF7fEtAX8Ht9ZzWahL+ZvAe6BSri4eXKnVcrGHE4NALvJzCuRWDFTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTt6C/kjdCMAevKTYUaffJxevk720voIVaGQK3288FzrfTtDs
	KyvPsMgrtgLSdqYSZ/fDUR4sskkD28fCkWON3MjEf7bA41EWMqwyMB52H3YxSCKA7D5ZGoOg3w9
	oUmSLiHYsQHGK+gG85nof7yJ1GHtq9cU=
X-Gm-Gg: ATEYQzwaW8sRXIuYw2PEU2qLb/Uy0qvYvJWiyvYjWugtXHhm62Is4J6LRdeBjKDSe+T
	D6EEwSkmujTOF1vB4cGbnnfao5TJKrzebLo6S9XZ0ZLJOJfGpDRentzxKFe8CZbnLidyENrIbo8
	2EbsZjdTVCjOqn0OCTzG2iczc61aL6LD7zhBhUFtO7uRB4HYf2eUfHYb1iH70xE6zJZ3o9cw5TW
	gyfVK8HTbdRllXlzb9+R2/UBg3JElYxg4uTWlzj1q5EkqCGlqvnkjPUzUW/XGYfXA6JSULKpD7g
	hbhp
X-Received: by 2002:a05:6512:1193:b0:5a1:3561:c6b0 with SMTP id
 2adb3069b0e04-5a14e46db0dmr517828e87.7.1773106681940; Mon, 09 Mar 2026
 18:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-4-vishnuocv@gmail.com>
 <991f8a08-7c5d-5611-7904-6c5d336a74a3@linux.intel.com>
In-Reply-To: <991f8a08-7c5d-5611-7904-6c5d336a74a3@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 10 Mar 2026 10:37:25 +0900
X-Gm-Features: AaiRm53P8wNeC2Lcw33Sa12VDuTovyX96CkTJT3bZYRAkHoVY2iDwuco_s3ogyU
Message-ID: <CABxCQKuojiPhY1J5XSEfiMaZFjKQLk14+n9TV05egzeWMQic0g@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] Documentation: thinkpad-acpi - Document
 doubletap_enable attribute
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, dmitry.torokhov@gmail.com, hmh@hmh.eng.br, 
	Hans de Goede <hansg@kernel.org>, corbet@lwn.net, derekjohn.clark@gmail.com, 
	linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo,

Thank you for the review comments.

On Mon, Mar 9, 2026 at 5:04=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 9 Feb 2026, Vishnu Sankar wrote:
>
> > Document the doubletap_enable sysfs attribute for ThinkPad ACPI driver.
> >
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > ---
>
> > +        * 1 - doubletap events are processed (default)
> > +     * 0 - doubletap events are filtered out (ignored)
>
> There's something odd in space vs tab here.
I will check this.
>
> --
>  i.
>


--=20

Regards,

      Vishnu Sankar
