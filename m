Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD837AA89
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884180; cv=none; b=Il/RQ4MmeMEbn02nZK+4NeEo/Obz2o2fKDrCAEMLDgvJFgE1EcbIIUgOZupCoaytVwP7+GuXpOlT13fmF5EJVOc8pvvCu+1J8IHRZW/IyrVkUgmZO62x+SNSZsawKDJ6Cxx6PpcYIRmhj6EQNNpGuSxdSr2MGRHKQOewSSk2DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884180; c=relaxed/simple;
	bh=vOliKEklsOkVi2OI7GEGcuD2cvljfQQ9hSmIICKD6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML8QAIi0xTPgGSTO7JM4P5c86Y0OblUhde0KXhpJysRED3x/7BaN3/Ci2fLLt8da9g3E5qFKJrxk4oIRWbjv+DI1Oc17PvIeYnYnaK2iSsfqWUfnQmmNIUSTQNaJ3zjowGXVTxTZcVNHGxeA1Sk/P9RIbljKnaYvYzK8Mmt9eMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ5gyb/s; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ5gyb/s"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12776bebe9fso632802c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884177; x=1772488977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sY2gQZyu0SZT38nxbLjfE/c3YsVd2LXz174z3vm70B8=;
        b=TQ5gyb/sr8NBLGRzSAUJZMR87ixey/NAp8QQTwTfzPnunLa8XvyJBva+t9MRoMqe51
         3oDp828niL4Xl9f8afs8ekL2dSuM+/R17kqLxVunuIqX4PHmUmFX4dqd6GTcTHRyQZsx
         /538iKUn5VfKadX8K/3xxUIGn1L1WgzfbeBiynF92nWz8Of6wjHaIapaj48onv35ps7f
         lS4ljH/sxs77LWKG2gSd4r5J6gqlOTBrG6tFJD7lcgHn92CaR0QDloL5uhFFbS0CZFqe
         e1U6spOZ01mrYW/UjdfJEB2ZkFDpBhPoh5Ob0wI6h+KhCxr6O7vJPWe/ttEB3zneeOaV
         BWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884177; x=1772488977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY2gQZyu0SZT38nxbLjfE/c3YsVd2LXz174z3vm70B8=;
        b=Tl2ocVbWGiFdcWkBn3/rQLAyBWIYiKig8mRXKHRgSO4TMi8Q33S7+IlqxyxijUpkTz
         AkfwV/EbkfhCUKT+sarwY0t+m5LK9ywag8gRbfJtGNAATxR5a+3eR4/3HVxIW3SUW526
         Sjne6Tx7+O8ieNLXMqNO5bYoimmY1gWDzttQEXWgxcfU5uSm1wWk2/CBVkuRVRNP6Dgr
         nUzA8HvF6PRTSzxkuuPzvwHeJmW1ZCZAu6UVZJ11+TtDuRJh2887cYUDPYcM6L+rf6K9
         JvAtIVvRIb1NRAv8tVHxpMAKQFRLZJIjJ+1U/k1InTYQqTBb5ebh/jYu+c/puBNuXwF+
         oXlg==
X-Forwarded-Encrypted: i=1; AJvYcCUy2GXAWjuM3k9cWY0gTb1lNIV8ur3pLcWviTwDRTplk+5m4tDNZMmO8iqHdlCJIsCEDVNJ7C468q/t5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37N2OZF0XPdvmWqoN4QB+Ct+4v1Yv90XvBHZA6X8iFpmT1kQc
	ZWdIb7j3LMA2IFMBYmT0+F0yawfXDyEFgBMYGdjriMbLkj/gCpqEIrUs
X-Gm-Gg: AZuq6aKTqS2t1jnB4z4HrgZp+TzpQPBhhj9z3m1M7aZEZ90Pf9d7Mmc48bxLqfSRrrZ
	ohxD9jHuIbWlyTc+BAmJzXe+cuo9Nw0C63yCUkstVpVMPmH+96F1wu0Mifl+WdCFX9xlzvalom0
	U6SUkp9550EkRNVSB2TRvsBzhjNgLKdnCykzBbW3lAJJb/76D6cU4yNkgPbI+lDD+kprDpuGGXs
	2bmV2yJNXqPQp6ITvsjdvzCbS8GVwxfN7lxsAdJxoCbqgsAxDW5XSDMJY4q3tuQYfpcUZ8/WpYL
	yzLrS30YQyyYZbyct5/Gi/LqRRaDO9JRsT+04WOYQPaBYrLfVfB55y5yEAACJqG5ZEOnxZoacqF
	a25zTfCnYeH4NKfm9pVCBctoppph+r9Ri93CdSA8a+fDYe7MMDUt7AdLGozE1VsryGv7Eo80qED
	VP7XZysR6/VPEM4CzJDQaKdwE4aouSIdv/YJUKVR+ZF9NzXk0HNlWnhg0iyboDk7FR
X-Received: by 2002:a05:7022:1602:b0:123:2c98:f65d with SMTP id a92af1059eb24-1276acbc65cmr4160327c88.13.1771884177083;
        Mon, 23 Feb 2026 14:02:57 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af20fc8sm9623904c88.6.2026.02.23.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:02:56 -0800 (PST)
Date: Mon, 23 Feb 2026 14:02:53 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, linux-input@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 5/9] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema
Message-ID: <aZzObk7Ripr0Uh6Z@google.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-6-clamor95@gmail.com>
 <177186521369.3975744.16898258990517269078.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177186521369.3975744.16898258990517269078.robh@kernel.org>

On Mon, Feb 23, 2026 at 10:46:54AM -0600, Rob Herring (Arm) wrote:
> 
> On Mon, 23 Feb 2026 08:38:54 +0200, Svyatoslav Ryhel wrote:
> > Convert power button devicetree bindings for the Motorola CPCAP MFD from
> > TXT to YAML format. This patch does not change any functionality; the
> > bindings remain the same.
> > 
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
> >  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
> >  2 files changed, 32 insertions(+), 20 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with the rest of the series.

Thanks.

-- 
Dmitry
