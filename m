Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFB478857
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987198; cv=pass; b=P52T2B+4IM96YS7dXk2r/VFi0cYdLlZiWl5JH5jfZVnQF6C0qPNUgSum1xSuW3Dhyj3ER7+8sfC0SJhZhLHYa0GTvZNP0R4l6A9cIbTyv1vycFyBGnrfqRmggSOnN8NsF//zS9X/ON3y/aQF5Bel9Iqb2FNsEBnwkj5T2KrxdQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987198; c=relaxed/simple;
	bh=79b775lMvczPPQ1sCHPV9x0iaa287H0D0dSytd73Qv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUEO9BovBlLhKKxUpn+G+OInJrAfZW2B9cZKTdVySvISxhdy2qufEz6xLxYYoXMIDafS54BlBL3dCWcvYRepkzGy6QfYOV0Bk+ZN//CojevhW43EQmTGh7YyOer0Q949wBtda55a3PyhwT+gHZ41R8YjjnmTEpIffTggUYwUj1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO7q7wal; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO7q7wal"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dd490be5fso176373e87.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 01:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987195; cv=none;
        d=google.com; s=arc-20240605;
        b=TBGrZMHH3U3I6nYf0J/D+fm4i+LFhaaEn+Dm/WQ9hqmXdSaP6JTf5L2fKwTFgeSiy4
         lvW2ywaAyQDkCiMNVE5h32Xb7GoMEbJ/RhnMtGC4Tk/dTK99yNXi+vnWQYLBr0aVQRmy
         he0IpXz2GewbrQkwkbtAsybqjV6549jhf7VxioiDFM2wCRXWXTzIu6C+xvVA/cuCQcVz
         g6/Flu/bd9NrJDRkaHvvLIgiBW4fIz6bu6CbeFWhFImCGyyiF7B1sxn8TDHLDggL+DmT
         Xf0iHMXbfWoeJ7NFeALHygLHP9I0JmvEuzrGWBtT6XHQkXN39bXDgWgGK1LA9GLpx9rA
         Xfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKTgJE3f1vXR3wpOnVsDNv0ntd16ZnwfsXCdqjWFLU8=;
        fh=ikRZoCL/inUL0va7a/F5FzDbDDA3rlDt1s1QyH2PtKY=;
        b=Nerqs8Yef86eduIiRewGQUsTXx4UDrUlhiES7iF240pSIm6eKOxBYTUzmWyv7w41Rq
         j5kEbJ6ruHv8Y3ybQF4AONoskrL5JJRPm+sOVBBkQE29gHmu5yt7/i7zwdhB2iieKSwX
         mlfujfmybjX1GC/cScVHdO1kzhXL0NSqG07WJ+V4qXFKkdDlZj9VZil47OBjXpcj+Twl
         O/mXOJKw6aLn1SOyC6gIRLjVNjt0gbGahzeva0aTJqlgySRpdjcwd/WOaMibJJK8RVMY
         GYv/EVSkWASxQ6cydhcsIHluSe8xHM5bPUOyYJO7Vhp4HgYQ41rJIKfx0o2FXCLsYY53
         rpDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987195; x=1769591995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKTgJE3f1vXR3wpOnVsDNv0ntd16ZnwfsXCdqjWFLU8=;
        b=jO7q7walxoTYrTV55gj7+zFq7/mMJige3Fi0WbTJ3uSmRNVKHXH/73RX99yEC1SoIT
         p0ZTk5wUop33HwM5CF+4aFCVnx5PTBh+OX7JmnDBk8JFzA5wZjndbqZULYIgG14SFKmM
         X8+c8y/dWwSeBcA/yabTEMSIs1IfTZguop6k8EAoXkNRq+swbnxzqSCeOjNRDknjTvw5
         B5Dad1l62CHw8iVU2V+osk/J2aIGzvxGz//VaeP5TTsZ4uVBAheXgswQYeJFz5OhDmMS
         tlqGzLaWBZRnRbNez19uotw0j4YO8wVG1pbcYuWwj1ucOMY2ncqGwwTVoZns+mhXsK6h
         YZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987195; x=1769591995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKTgJE3f1vXR3wpOnVsDNv0ntd16ZnwfsXCdqjWFLU8=;
        b=F/sCtXl3sdCpmQmjq30HdqiSKypeIBot5TMCVwudnq3okVlQtQd+SKCy+cAJeRK0Jj
         0ic7Fep7b7oQlha/oH9XODGWBWTZlsAdXg93u6UjMlSsLgiAluLkZfTGr+lXm42DF18Y
         4huSjLVPmnK8njv83kjLCnlgBr/vwCXNc6886MmfoMgVHPzZc9VojUyNhwIEwgvs9qgd
         AG1etxcG1a/XPDGHf06FjyElKprqwKl+zKWniX0XyK5oQo1Rwmy48vtROS9yb2Aam/Fj
         HbDpCpTbIQqPJDITQX8egey3iKGBqssW9j0Hwt6cYglMAjYUoiL1bn/Jh43R7Pd8v6/d
         xz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUAKvNiVRn8jtuYFjtgeuE20pknTp3iXdISTKzmUCZN109YG3jtrSiCi+onAICJI9T3rQfnSjcES/NpGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTSiYRd37wFJrogbqn1OBOwyALIzUoBRW8eaPg+HwzET4EU08
	otO33KKLFr5WBOGnSb6aKInqD3zzeOhmLAoEEkgwTAlyZCuSbjtPUAOJSpR1ck4RDfbT4DqqzHV
	N54PfYViOSIjySkX3svA4kmVqzFjKasY=
X-Gm-Gg: AZuq6aJjrC3rTBJNs0ZyChnWfkj1H/kHLZBMoCo6MKKvUIyIZjNA3Ik1x0sE9UQPuiy
	lg4ZF7Oxy41ijzMi1nx90nehj97f/h+lLb3CY5Y8peSuIp5sU8p/2p4RWaddIigURfCajtpJZeV
	oBKM6kPGfx2YgfyvaREvhOV43ur8B7ndnMf3xzZ05q+8D/+BgmyqNMyLfsbXqPeGTs14Pn0snxT
	Ym3HulZKbb1XFIQBBST6mG1RPaagIEzhjuSVIBzn4gU41COCWdwtu8+tTuJ/zpYqlc8ev474NOl
	4iY+yg==
X-Received: by 2002:a05:6512:3ba7:b0:59c:bf2e:fa15 with SMTP id
 2adb3069b0e04-59cbf2efb55mr3787256e87.5.1768987194335; Wed, 21 Jan 2026
 01:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226235101.106451-1-vishnuocv@gmail.com> <20251226235101.106451-4-vishnuocv@gmail.com>
 <aW7Gh6WsTjVo5IO_@archie.me>
In-Reply-To: <aW7Gh6WsTjVo5IO_@archie.me>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Wed, 21 Jan 2026 18:19:17 +0900
X-Gm-Features: AZwV_QjqEORNJ_8f-MFBPABn9dnWmNGoiIrX3uwxX_lcnvbIxZvfTJIMH0UgnWc
Message-ID: <CABxCQKuF_1w4iGwH4DVwWZSo1bfbUui8U_RenGBj8JYeCzOG9A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Documentation: thinkpad-acpi - Document
 doubletap_enable attribute
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dmitry.torokhov@gmail.com, hmh@hmh.eng.br, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, corbet@lwn.net, derekjohn.clark@gmail.com, 
	mpearson-lenovo@squebb.ca, linux-doc@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
	vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

Thank you so much for the comments.

On Tue, Jan 20, 2026 at 9:04=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sat, Dec 27, 2025 at 08:51:01AM +0900, Vishnu Sankar wrote:
> > +Values:
> > +     * 1 - doubletap events are processed (default)
> > +     * 0 - doubletap events are filtered out (ignored)
>
> Please separate the bullet list from "Values:" paragraph.
Acked.
I will update this in my V6.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)
