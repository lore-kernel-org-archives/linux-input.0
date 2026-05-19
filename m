Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363E351C24
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216438; cv=pass; b=mQialOAcGd8c2dlgRxmULgjwIel0bLc7wVdC80gmwUbKV8zrEwG+PgN+yh7EInz3+H2mUJmTz1zzFe8VJRR2eVqcEcmoK2UoyPP+2Mx+z3AqEy9YWfBq4aZ2iuL1xzkWnoANiXzI3PFpYUCDchgl3ihHi2JFjsbFVEXj+g7CfJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216438; c=relaxed/simple;
	bh=3x6JR/hriW7jM47Wz/ujqxtYfqXy9KQCHM6qZbNQZA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb6Vb+GRPZwBPaDKs6rPOxSC4SvGOrZj9qn1nOIBJ8E6+W/z9xiJGI8E/YBG7WL58CnETENoa3CZ8rwfgdrwvTkhIZX3gmmXoYtqDjL7LBkYOEYcsdDIG2szcSDO34btTT9EyLopekAlFwMnO2PYimK4T6e/LNbRh/uxcwnvrh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hi0l9WeA; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hi0l9WeA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358bc9c50so630144766b.1
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 11:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216435; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJrKkdIJUF2lxBIlYXjZCenzkzd76atqzjY9ptNe03bAVGYV0a+vy1Ws7XMHgASks8
         u9xXSD/AhCqttnZKTAhO8q19hTayzrMU5azOmlT+7cm7kpQ+jzfzZQGOSjyttzClibQA
         eH/7x5N4KumtH3VHxv1tfB/kMWg63rVtJGuBumSj+n+BNqKc404oQxQRl2R/s+Cz4ZOO
         ZhxXd5dPg9Z/Ns/jRdaHmpXksFN8khDmpUbktDtD4Hqefa4iTcRQPESbXn5SX8OIO70n
         YcNhj8R4PBIBwBIJfy5TcbU/fAyd7gF815YNz/ZT7no9R4cPbAtDfWHIHQPTnjx/PwiA
         UkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AR2pr7Qz/zxn5prgAPCjfKDhISGifeV41jij8rffnzg=;
        fh=M74kXtCIRXAteLr2bEMsnHBw+q0vY5pH1xuBRvyU3Ws=;
        b=TNuI5eMluHjsgDBQ+SRLR5jdXu9f9OgoIW1UkAAVs67h/kMTgleZivTzOKnW1GrZIW
         9ISC0VKakMlcyGOkOxodcSIiIOTJzoFPka2EDoB/sAuklomjVS7vyhZWtMDTMZ57sBwb
         PnouR1nVIvV0b7BiuIveVp96mgNi1OC+IAvBZaiXjh+/PBdq6gqRJkTbTGaKDjP1ufhL
         dHM2oWhlJRfuA1ugbnTnuZZd/T8wJM1xOwB7C89HHEzpJraWaj3VLKDADq4OjtxIkM8R
         AiVfSEZjml/IlTIyY7PhTn2rzOCeCucsFNqklzUQ8lY1unHAYvwh/qOdQeTp5XJcxWTc
         Rpxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216435; x=1779821235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR2pr7Qz/zxn5prgAPCjfKDhISGifeV41jij8rffnzg=;
        b=Hi0l9WeAjH8aPaDWQkF1ayvFZKJm/19ezFpKwB/DYDtkMC0roSEmD3FcqtNlzNCjUD
         gkdDIXsxfpDlEhpIiXlEwgqTThVttZzbLXdmU9y1DRCV6DoXuVXCmDPxUqX08/bE4SZ2
         byAytUVczt3G3lnqxtOwFDXnMY8aZBY6Fy0kDG1h5ykzFGdlwZ50Td7JddyLrRkkUfIT
         KgelW7bfBNgO+In5ioM2DxXDyxwhgNrCdzQiiC9sB2acaPpDqqr8QdVF6CQTjrRwK04E
         dVjGePJNjBu9EXmBlwI2F67IF42i8r4aVJU1ey/zVQpRAW5GodxUinJXLGFEBimUczGQ
         xs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216435; x=1779821235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AR2pr7Qz/zxn5prgAPCjfKDhISGifeV41jij8rffnzg=;
        b=V1k/56AuXt/dVb5j3HxaaSKebnFqBIGrO64aWimLKXc1fThER8FzsLj3gCL/0R1rxk
         2J0lNxssVxBuhmNtvqUdrPL+dYSYuHIfsuGNl8GrLHXu82otjfHCjl62MA1YB73P58FC
         WTc22FenSk4/BdrnXGKQCc76BdpAMniHnL4kiSru76ZjH3N/BV/834tFq11P+4wmmQyU
         TXbpyP+xAgtTDE7K8CpX6nGiTSsu3d55mUD8xUcoEObx23dH+Qz3a7vgT8JxBeGEbGUj
         tSVoHoOo7VYPrEtfcv8CubKLPubscfmyxq10FAnSGNS1J6jqVFbZiBhnRaaEo5nrVRRs
         2qPw==
X-Forwarded-Encrypted: i=1; AFNElJ+zzq5hPmurqfiJOHE0thVJivRO7yFO0iE6X8VDlr104qfhFEqp0JQjNnr6619jNiiAe9UXBIE1MhLVEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQijI1k4I9O0iuJZhcjL/Hu6+XFMeLxYTm49s4D2IjM0oac+Zu
	J1Shxvkrl3mjyGHu3gXDIXa4iGK/2WsDO0OzOQOPxJM/a3fkculELFRp6MZ1i/r2dZhvZ1v46No
	P8P+VSK1AnOmC/eR5Wui9mWzCmgObxk49qMA5vPdA
X-Gm-Gg: Acq92OEZVmCh1zHSDevmX1Cz+Ki1L8+cN89Z9fQQayjWu2bTW0l4nnvM1UwROlk7VDi
	p77N+PkXkKBe7ar2F40K4Vw9JcjDmMMqldxUrVEddHnpQBxYQHOaJYPOaFCIDFHXM08O5kbLv2G
	sMtx6/leISJ6FUk6opAkvArmaAfHb1rTqk64cVfuAUGoyQSzX5RBcmQumjK91TiU1JPsNZNpIGS
	g60/WEvBLdfBfOay3PF6nilup5qlVOMtrfTRBn3BSrJa9vuhTxIQVcoDx6cJjcX1EVYjOJajGv4
	fhyUKsea2USNoY4e+OVXfFtVdtKHLmPs26A0SKCn2cDja/ndUeGlZ/bRZCF9nthth+jP2jKfcGw
	A3dSUie492qHUyMaTIsiYC2zSuPt49Eq5jNEDALdRX5Fc8tmUuXA9iYziyCqYn7ggSp+D8V6Cwv
	dhR67ZT2qXCNC1G00iBf9pktxeneb73Q75jaWOr4n3tLoOXl6VwB8Orxn7kQJuMR8ejmUw8hfXA
	svi6I3FwTa0JYCDRfg=
X-Received: by 2002:a17:907:6d04:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-bd517aba010mr1158723466b.43.1779216434314; Tue, 19 May 2026
 11:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512132244.2194556-1-alainmichaud@google.com> <64842eb18284bf49ab1e283b0fed1e6bdea7037d.camel@riseup.net>
In-Reply-To: <64842eb18284bf49ab1e283b0fed1e6bdea7037d.camel@riseup.net>
From: Alain Michaud <alainmichaud@google.com>
Date: Tue, 19 May 2026 14:46:55 -0400
X-Gm-Features: AVHnY4JMEr0-WjV23MNwaEEbHr-n8-BB1tpwGJhTB5Bbr3cdxB8wg07axSpZD8A
Message-ID: <CALWDO_VZKqTAKHNpUCU9cYLLBmdVKfk=H-pmPZLOz28QsoBEZg@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for newer Bluetooth keyboards
To: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>
Cc: jikos@kernel.org, bentiss@kernel.org, hadess@hadess.net, ogay@logitech.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:38=E2=80=AFPM Filipe La=C3=ADns <lains@riseup.net=
> wrote:
>
> On Tue, 2026-05-12 at 13:22 +0000, Alain Michaud wrote:
> > Add product IDs (PIDs) for several newer Logitech Bluetooth keyboards
> > to the hidpp_devices matching table, enabling full HID++ support for
> > them.
> >
> > The added keyboards are:
> > - Logitech Signature K650 & B2B
> > - Logitech Pebble Keys 2 K380S
> > - Logitech Casa Pop-Up Desk & B2B
> > - Logitech Wave Keys & B2B
> > - Logitech Signature Slim K950 & B2B
> > - Logitech MX Keys S & B2B
> > - Logitech Keys-To-Go 2
> > - Logitech Pop Icon Keys
> > - Logitech MX Keys Mini & B2B
> > - Logitech Signature Slim Solar+ K980 B2B
> > - Logitech Bluetooth Keyboard K250/K251
> > - Logitech Signature Comfort K880 & B2B
>
> Hi Alain,
>
> Did you actually verify the functionality on each device, or did you just=
 update
> the device ID list for new releases?
The later.  Not all the functionality may be available across these
devices.  However, these will definitely work with the Multi-Platform
feature patch currently under review.
>
> Cheers,
> Filipe La=C3=ADns
