Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF74346779;
	Wed, 21 Jan 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986502; cv=none; b=S/DHdaHtyhfFwlNDGZyiP8tINyDGDSny1MseS3UfSYFIp0ljHfnprD3NtyZjIZ4NDP2ZjYC/xg63WxhHe28aaUHFrkQ10SQVzb3rL914mLLeRKfxpJs47+M9CYu5J8NQPYp0EJSgjYoEZxwKEZqCCYExDGCwSxJcA8vdVSBCBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986502; c=relaxed/simple;
	bh=klnW2xK3hLbSk0oSDnMsm7oDxbD9b6k31GzqJeQ/ENU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h/uhLvk+uPkPYuVNymuiK35t65Q7olLrXGO6zzVE/mT7uN7XsMOLXggZ/hhjsF/xG4eZUxLD+N2xwHEdrx0IDAEWaHJLhIOvMVyMff5f4YXB5gjtr43zFe4kq1itElbIMnf4O66dVCFVDammmdpYhIyeuUTn6Q1p8SXNSSYCAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8rAJXsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8rAJXsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605FC116D0;
	Wed, 21 Jan 2026 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768986501;
	bh=klnW2xK3hLbSk0oSDnMsm7oDxbD9b6k31GzqJeQ/ENU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=b8rAJXsyuS5ZqbcaoonsyMMvS+0OJ/BHwUKCrjyM3ZPqOMXpJlszbF3SZ6CEGTA8Y
	 cdrYTwCLBXoOktteI9ekXo+g0DstSxvMayjoZJfCUYcXhss90qB77NFltDVPPkw0jV
	 94FgkKhHbUL5AjBdHKucrwzeBYHNe9ooL2DTRdoPrDd8BRGtBwr+qo3UoEGaygmVxU
	 IO3kOzeuycxb+0AmUCafoxci3gBejYB1m4nGkzgRwZyeLRJbu4IeALHgp8odUov0xD
	 1PAB4wFPj+jgmLuJrH9AgNPfC0ghTpkknonCIC0/WYWa/d2NhaSmaXGs/hsgXlmXcn
	 5/IYfxvgtVssA==
Date: Wed, 21 Jan 2026 10:08:18 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] HID: hid-lenovo-go: Add Lenovo Legion Go Series
 HID Driver
In-Reply-To: <2910bb2e-6b31-42f3-a3de-463327b16ff1@app.fastmail.com>
Message-ID: <24on5sn2-2726-84q2-635q-9245n343qqrp@xreary.bet>
References: <20251229031753.581664-1-derekjohn.clark@gmail.com> <20251229031753.581664-3-derekjohn.clark@gmail.com> <0on4p9s6-7512-9408-49no-3292o86113r3@xreary.bet> <6BB4F74A-F440-4F21-B094-62CFD18C599A@gmail.com>
 <2910bb2e-6b31-42f3-a3de-463327b16ff1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Jan 2026, Mark Pearson wrote:

> >>I am now almost finished with reviewing this pile and am planning to queue 
> >>it in hid.git shortly, but I have a question regarding the MAINTAINERS 
> >>entry above.
> >>
> >>The title claims support for all of Lenovo HID, but there is much more to 
> >>it than drivers/hid/hid-lenovo-go.c, specifically in hid-lenovo.c.
> >>
> >>So either please make the title more specific (or claim the ownership of 
> >>the whole Lenovo HID landscape indeed, fine by me, but the please reflect 
> >>that in F: :) ).
> >>
> >>Thanks,
> >>
> >
> > Hi Jiri
> >
> > Sure, I've debated using LENOVO LEGION GO HID drivers and LENOVO GO HID 
> > drivers. Do you have a preference? 

Either works, as far as I am concerned.

> > The other drivers are pretty old and I don't have any hardware that 
> > would use them so I'd prefer to keep them separate (though I'll 
> > acknowledge that they don't seem to have a MAINTAINERS entry)
> >
> I should probably take a better look at the lenovo-hid driver.
> 
> The platforms that it's supporting weren't in the Linux program, so it 
> never crossed my path before - but looking ahead I think we may need to 
> contribute some changes there (guessing a little, but I'll know in a few 
> months time).
> 
> Jiri - as that driver is targeted for Thinkpads, I'm OK to take some 
> responsibility for it if that is useful/helpful.

Perfect, could you please then either send that as a followup patch, or 
even have it included right as part of Derek's series?

Thanks,

-- 
Jiri Kosina
SUSE Labs

