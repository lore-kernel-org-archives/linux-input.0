Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FA26C39E;
	Wed,  8 Apr 2026 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686121; cv=none; b=O33/J8EtWqKmc8FzgiId8fgTgV/NsjetboZ6iO0C5X/uUgr4ySlIx017Lg8tS2mbp5vE+Ox3yQch4nN6E7sdgJp/lDSbLAAwDGEfpzxMGID5QrmKYdnxPoTd4798xlMqwb0Vckf3ViVm2U9PpGroxONP/yg6a/xxQmi9yC2Z1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686121; c=relaxed/simple;
	bh=di4ZdKT68JSKWDiL7FtCgaCXUO2niJYKax4HLajWo2w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FL8BjjzEkVkmGD6G695p5S2IkCyDQkiyLLfIgF4BzkfFPL6b/M6T6RA1syADqS9duN9kwglbbuL4hHPiwOC9YHUx8hx3oJAtZmhOhkrrMUyBWuEaxc+LrazpZOPiHGUwLHbF5IjMEYG6teZ9s7O2UE8kPVDPYIpJRLNqp9kFAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqjkhNrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqjkhNrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B19AC19421;
	Wed,  8 Apr 2026 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686120;
	bh=di4ZdKT68JSKWDiL7FtCgaCXUO2niJYKax4HLajWo2w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RqjkhNrhTpDVGBCk0dp4f1f8sCvQvrrby45KnUWGn9GA0xg/Lydf3JCjge8colHnE
	 CXKs8g9WarpaPQa0kh6we1zUxcEHR1xnn7oDGUenfcTDNoCnWeY291XtIVWk+s/w/1
	 wI2wppMX4KvSYgFGzUmfk1bGn/FXho+nr66Qq8a8unNcanoaH3UY/oNdQ/AiKRSyiw
	 BsVVk2WuNtDDGevV0X2i/xIjZUICGor/CTzeMalCFXteKCeAzfpLRhz8WYapUw6Myd
	 0QDTs234PgUFHIFe+v8OPKvONMkI/l4wwnJ/WXyMHcxg+Ly9XqujepLfh5nZtijbNJ
	 IWF3CpDepulGg==
Date: Thu, 9 Apr 2026 00:08:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sanjay Govind <sanjay.govind9@gmail.com>, 
    Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: add support for more instruments
In-Reply-To: <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org>
Message-ID: <o488s484-r1os-6736-o800-7on55687757s@xreary.bet>
References: <20260407194636.9671-2-rosalie@mailbox.org> <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet> <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Apr 2026, Rosalie wrote:

> Hello,
> 
> I've sent 'HID: sony: fix incorrect Squier name and remove non-existent
> device', though I will mention you didn't apply 'HID: quirks: update hid-sony
> supported devices' cleanly because it duplicated the vendor and device ID
> defines in hid-ids.h for the Wii instruments so it will not compile, I'd
> advise you apply the patches in the following order to prevent issues:
> 
> 1) v1 of 'HID: sony: add support for more instruments'
> 2) 'HID: sony: fix incorrect Squier name and remove non-existent device'
> 3) v2 of 'HID: quirks: update hid-sony supported devices' but without changing
> hid-ids.h
> 4) v2 of 'HID: sony: fix style issues' (if you want this patch to be included
> that is)
> 
> alternatively you could also do:
> 
> 1) v2 of 'HID: sony: add support for more instruments'
> 2) v2 of 'HID: quirks: update hid-sony supported devices'
> 3) v2 of 'HID: sony: fix style issues'
> 
> I hope this doesn't cause too much hassle,

Thanks, I will look into it. But going forward, you really should either 
send this as series, or clearly mark the dependencies. Sending it as a 
followup fix in the same thread also works.

Or, even better, send a pull request against a git branch if the 
interdependencies are tricky.

Imagine you're getting higher tens of patches a day (including e.g. quite 
often v1->v5 within a timeframe of a few hours), and you are somehow 
magically expected to untangle all this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

