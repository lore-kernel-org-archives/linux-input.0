Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA027260F
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772983188; cv=none; b=Ws6OCljSqpFyV3Ivqvq0sr9Oc4v2o59yweKwGQyu3P69plQVXKWCHd4yH2bATCZKXv3v3MsUUISisYwo7QKWMt2JmOHfeCbTVygVwnrYzjtUk6RkfBax0QcQliKdZhehBy7iZUfaWAJyUIIjFZBGCyDfvlDpRr/WnttunVGc96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772983188; c=relaxed/simple;
	bh=tKeS3fZ5eXGVdj5qMTsvi4Cpz133x8YuRzhP69hH6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0TDFsInCzZgzcpPTIDk4v3fENsQBx0loqyWFrZmPvGL4oDAtKCHlWODfSViCygwK891BNoqkg+p3YiKPPK4VQyTQkoVw/y4Jr2jlOrhQv7T4FW9HAsge5FN9l3kTIfH+XkscEkLiInrcCPaUdHokvHl+mtyEvdUFl80jtkhX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Esxr09eC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Esxr09eC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb39647a70so1056297285a.0
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772983186; x=1773587986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A637omd0+l72zT22T4XwpP9C6X9vAt20cQZu6voj2uw=;
        b=Esxr09eCWpOT3TZ3Ixma9McbCe5eSq8tDZ4Ld9+ED6A4IdP0kAXdHFX5ChaqOc/e1O
         Xhl/Y3ytnLKgkkpEDoVHdJf8inHc3Se6LZ5LDyG1Vo/kCrPV9WyUzj9uyLPtRn9oQZ1w
         OPk1bEOfX2HSrMliY0wrO11LZnIR0YSWlwra5Plx5SRvoxfUE0epvUtEGP7j7fAKFfxq
         YGZFfQcOzjbVXF79vfBfBhQTewn5bN273xPqy8Z2p+75J4LfFCo4ETXvzmJtAxw2vzyE
         hnWpF8iT6piDEzQjMnAI5hVQyAAlpjxUEpUqwrV2RTAsRqzid3cQVJfJwIsA3txXo9+6
         lcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772983186; x=1773587986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A637omd0+l72zT22T4XwpP9C6X9vAt20cQZu6voj2uw=;
        b=f5bjXhH1ORjoMeSw5PWKMM9AxZ3dxHSINnoRIL6H0uLoLTrpIIloazfRkSBzVxmUBp
         H+axgjeEk3IDKK8PLaVqDwACiWplJD/CDcsqNP3fiB5QG15Fl6EqnsYuOEvgOiP3GXPK
         2+PSkswJu/oo3fUmaQR+T2FXr7NGG/0CuQabR6SXgpgUvc67u878EQX2j05F+wn3m2pW
         ddiXXr4R3r2VeBXSSCFMWONNkTPGC3GoYhZMUL65S93NRjSeMBr1N8u+yvXUKTKhrhDl
         WJUJjryCD72HoMVaYUoo+cQoMWtYy7Efb3hSg23vDAFra9a/p3F+h468y5ZQCjOwutWO
         2LlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfPD05/RDQXv5FIQGxSrHZdg9SNmF/vNk4eTRKlJ5ZRfckWkPCCtADmj6lIPwL22+IQn6LtjbXKSzOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eEA8niDpEX0lyy96+d7zQyQuXSPLpXF9W0SGiQi8iOSOPmKM
	rMeIlMzKE2Wv24XeC6kh6IITxs3+NYJ5Ti1QP9c/lVqhTX6BJbWDmvSobwbRtEKRKw==
X-Gm-Gg: ATEYQzzu624dsWdxbr7I2W0E14Ly+YjNNgb4be7sOIJiQ0a4H+OkP15x2sAm/PlBCAW
	eEal7FGTeH/wUQDVfgLCMIeKLt79Pr5+xhVeGo5bI+PKWsFwDdUDiedqgwbfZkD7Rv0T48VngV0
	dSs0MPvRBUgynnyJB8BAqjOotSsb8G7HsOpB+aN7DJuJv+RRrv9tOszU0qfegv5dOzGVb19rIUG
	ULwJhcoSDmfbN9cj19amxQcWEpZIOGQVv1yMmyQl/AdWNMQIPYv/aQfLmIu8FZllMIPllb1KDXA
	5B6sKWfEoS4waUrXiaRby7JJRJ6owoF1TLSurcn2YslvACK+d7gQ5/KBZoQz/SLoql+pWY7xaoz
	8/8bQTKBOqw1hQt/cvkO+RedODBzLJPsdMeJGRZWrBcQ4zmO+UVhgoDXw3iQ1Q2pPp3uvgmgJJo
	sj2055VuE2hrTzIB4qNGyrg8+W
X-Received: by 2002:a05:620a:f10:b0:8cb:b0f1:cf29 with SMTP id af79cd13be357-8cd6d4fb264mr1093152085a.37.1772983186026;
        Sun, 08 Mar 2026 08:19:46 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8641d344sm69812185a.31.2026.03.08.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 08:19:45 -0700 (PDT)
Date: Sun, 8 Mar 2026 11:19:42 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbhid: tolerate intermittent errors
Message-ID: <85909b1e-2aaf-4fab-b691-6c82612d3238@rowland.harvard.edu>
References: <20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com>
 <6cbc6c70-8252-43d0-8701-e1613ddc769f@rowland.harvard.edu>
 <CAOQ1CL6GcPUDw+wriKtqq05ywkuhjyi-ujp7WwFpSWgY1fV1zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ1CL6GcPUDw+wriKtqq05ywkuhjyi-ujp7WwFpSWgY1fV1zg@mail.gmail.com>

On Sun, Mar 08, 2026 at 02:48:42PM +0100, Liam Mitchell wrote:
> On Sat, 7 Mar 2026 at 23:53, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Do you think a better approach might be to reduce the 13-ms delay to
> > just 1 or 2 ms, and perform a reset only there has been no successful
> > communication for about one second?  This might perhaps be _too_ lenient
> > sometimes, but I don't think such situations will arise in practice.
> 
> I would prefer to have at least the first error resubmit immediately.
> I want to reduce device downtime and missed events. From that
> perspective, I want to assume the error is intermittent unless we see
> evidence otherwise.

Okay; a single immediate resubmission won't cause any problems.

> The current reset logic "reset only if there has been no successful
> communication for one second" is problematic because there is no sign
> of successful communication if the user isn't pressing keys or moving
> the mouse. Two EPROTO errors 1.4 seconds apart will trigger device
> reset and 100-200ms of downtime when ideally URBs would be immediately
> resubmitted with only a few ms of downtime.
> 
> Can we infer from not receiving errors that we have successful
> communication? That might change the equation. If we don't receive
> errors for say 10x the polling interval, can we assume it is working?

Pretty much, yes.  If the communication is not working at all (for 
example, if the device was unplugged) then an interrupt URB will fail 
within three polling intervals.  10 intervals seems like a reasonable 
limit.

> Ideally the reset is only triggered when we are very sure the device
> is not working and needs it.

Agreed.  I don't know how frequently the bad states that HID devices get 
into can be fixed by a reset, but I suspect it's not very frequent at 
all.

> > The reason for having at least a small delay is to avoid getting into a
> > tight resubmit/error loop in cases where the device has been unplugged.
> >
> > Alan Stern
> 
> This patch would only allow one immediate resubmission per window
> (500ms). How costly is a URB submission? I was assuming they are
> relatively cheap and even one per 100ms wouldn't cause problems.

This problem mainly shows up in syzbot testing.  Submission isn't all 
that expensive, but in the virtual environment used by syzbot, failure 
occurs during or shortly after submission.  If resubmission is then 
immediate after failure, the whole thing becomes an unending tight loop 
executing mostly in atomic context, which ties up a CPU long enough to 
trigger a warning about a possible kernel hang.

Alan Stern
