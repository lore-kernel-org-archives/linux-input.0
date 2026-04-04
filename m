Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965817D2
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 05:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279620; cv=pass; b=NkfkfFZKDaypREBsNSyOufTtaZBRuVow2nasKmwTRORmDjt3vWL+tZNxA69d7APmMtrBpWQKajpNLAQxsIfhnuFffCetGDzfh7Piu9NAQeTKK337FRAMF/gcsMsFXHxP22vjJ5J3JgjJgw4lfHCiDsjXW8Ih2CjhMPVF2gAUx6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279620; c=relaxed/simple;
	bh=hu9YdciqMZaHzKCiyWpxqS0/kTaAjnki+JmYNi+iekU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNEZH7PL36dkd/ANDXEjlQiib+3TmArmRqqcCuob7Ujtqu0HyE4NBNyR2m2k44Ow2mYvpY9A5u8X2uCj/O3DU4k4e5JYoFVwqziCZualej2Ky6r8uCznk8tOdz9aImBXhqtbCpFsT7eJPnKqZ/+kMdGE0Y0/Gxt+4fIAfl6iImA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7uoayzb; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7uoayzb"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so3162717e87.3
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 22:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775279617; cv=none;
        d=google.com; s=arc-20240605;
        b=bMV7bdDwE8OWuu6McLhZK2Vf7rF7S0lUZzy/R4a+JDOxm9pK5WuclgDjh9L0lebRPf
         7/GPjvixAU3R0pHUiwOXraWkL41MofReECAVwaK5xmGjFNAB/JWdxsW3Vb/trp1ZVsyH
         DhKrRXJFAQ4fIXHDLxlpW7g9OIBLp1DdN1mQNjjLeCshksjfB8FaR43ZNA+jWmZFK/xe
         +jGcrBHlTQzQtrvSCcj/WTr3PSO/2v6VfwwtoTQ/307XaG+9ddf2VE7BORBVtERhmDWm
         gCNEO41+dedjC5LHuSf5VNccq56IaiiTPrb947BIaadxlLueNx5l1VVrzRKnZTPfzRwx
         0Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hu9YdciqMZaHzKCiyWpxqS0/kTaAjnki+JmYNi+iekU=;
        fh=1M5yI5p+XTaPWedLnbs9wUKj3GB5RwwUFegc/3K3YAk=;
        b=VlYXJWKXBQ5Oyjh12U2EK+HQ1TYREHW22mQK2BBl3oWW+ennZ/PcEr9B6DldM5ht1Q
         wGJCtd23jIFQXXcMF7HDAuqm7QLGNP+pdAJ+mjQ9UPY7S/BarXjsch8foHrX+uhWx9/S
         xT4mTCQw1o9F+Nm03ahK33m8gtUljRZ51i28MrY0UpqQAXHou5+8ZZZjRZVRGwNdqDcX
         /63vnIwsQKnZd6HejtvVJyJaJvuWktZX8ukwLrbOo7RN9nkwImrgPwm5i5wbkDtj7ZEb
         T2iPjzIiRaXIjZa7parDugXrL5ZjmWmsjV0RVzYPmg20z7G/+9QUA2eamXUJEaTp1Jwo
         PZcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775279617; x=1775884417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu9YdciqMZaHzKCiyWpxqS0/kTaAjnki+JmYNi+iekU=;
        b=G7uoayzbH43FVjThL979mL0QlFKwInJX3IbjqLxMmeFll5xa3OPevG6/T9txsSvc5P
         5ckjxt6qTy/hVVi7ot4eJoI/GL+oP8HZTzvCG+M0kMg8KkJ+bu8DYV4dD+1XKZa3rDdq
         DDU61Z5lWz+NsK9WtKSUrqTtLNR6Bny4oZ3jT97krgHtoWMscbw723LsL0U78H9y4KHR
         rexCm8v5XdwbQ4S/glTVOLLduwh064YD5ko0qVPWzXrhb6JR1Oets2DVVXLo6DEBTVmn
         OSwUeGqgdkWlaOvEFtB8o/HTDX1MyaLR0F+TRKoNFkttW+xqfUv5Zq9wztwkUurAQHHT
         aijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279617; x=1775884417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu9YdciqMZaHzKCiyWpxqS0/kTaAjnki+JmYNi+iekU=;
        b=f3fqqRsqgeBI44dOpdXdsnGiWCQaWK6Dm7eTtMNhsyvNoBKM34SIm4ogpyn0fRdjMo
         7qcuL9QcpmbxZqLRHr7Zgm49qK83kltlVc+GPwx6xbVCYLR0tZXRpTvXm4s2y0mcp74I
         waCAzBri6tH2kWQHKeJArHGy+f5EK97bEqMDh6wPbbVnDwL1SP+R2OcsUvJI50j3h5z8
         c61V97B6Fq4A46OPItONs52Xh7sQn/OfHfsD4WaQZikczafmJGODQt4tMOBPlMBs0qTG
         EB9soiwYYAYolmDr4rhtxJlgvLUnHUCl//Bj5Pgqxdk+A9m60rhAoz3SybtGv/D6g1Wc
         4GLA==
X-Forwarded-Encrypted: i=1; AJvYcCUCX+ijKbnDAFhfbcUAg7LxW9hnD24KKlbEx6YO1oO3tO5EFELme+IajXRwaOlfguo8QtoIjylzQqro3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvFqmr3VlLDCuV0hq46GLlt+nV62GPvBKzWBDx8rcxCEbKFzJ
	cbV1Y8e4hUwN0FKp2p7fMHWLz/ethmB8kRdE5K4F/Ue/grNG40eiZTtW6LwA5nq1VCluh+E+KOf
	OE3vIpU8I1M22pHRCVgnnt2a3yzitbYk=
X-Gm-Gg: AeBDieuzX7MmsELYyTmC/sLzr/H0pfN2BvbunuCz24kIUNUSpODlkW3iUbn69BY2G5J
	eHTshrJ6Nq0i8IOTI/uZiEpqG2h7oGjkaf8MYACDfZOND1w2o6L7ug87DZln31c3X7aCbGZ2S9n
	yI88PXVZ5ntRaPSQBfn/AxMerkKsWdLZDvdnxa2bLze7tRX2Q9cTOg+Ddqt3qX4X/j6BBh0BOY6
	9WYBXUdrYSFao5EC87ZJPR9MBR8Zs5aVYLkXItWS+5D2rQPcGL76iavgEiYg5yjnakSXYBEM5EP
	HlzIMScbfVcPt7eVOkS3osio717KkwddNgHOzgErwfGDSWb2xp76DPfDfUeitLS3DeaoivYsIQX
	7j/T9H9I=
X-Received: by 2002:a05:6512:3da2:b0:59e:1880:2ef7 with SMTP id
 2adb3069b0e04-5a33755d7ecmr1521997e87.11.1775279616696; Fri, 03 Apr 2026
 22:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311213106.271577-2-sanjay.govind9@gmail.com> <adCb-7uNtq90McnN@google.com>
In-Reply-To: <adCb-7uNtq90McnN@google.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Sat, 4 Apr 2026 18:13:25 +1300
X-Gm-Features: AQROBzD2_W5oHL8YET_yK0WV7pDshRDMNf8BWfrXnfBlNobRUrLx-hwbCtUCHdI
Message-ID: <CALQgdA3AzKnjD-rooix=8K9-Vh_zZa7HaZdM-mHhgqg=tVPxYQ@mail.gmail.com>
Subject: Re: [PATCH] xpad: Add RedOctane Games vendor id
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Lode Willems <me@lodewillems.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 6:07=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Don't we also need to add some entries to the xpad_device table?

It's not strictly necessary, xpad will pick the devices up with just
the vendor id, since they have the correct class, subclass and
protocol needed for matching, you only really need to put them into
xpad_device if you want to customize the name or give it different
flags, and that isn't necessary for these devices. A few of these
devices are still in development, so we don't have PIDs assigned yet.
