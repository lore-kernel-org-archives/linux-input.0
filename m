Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE27081F;
	Sun, 29 Mar 2026 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814572; cv=none; b=ju+KSeM7ZETUfwRzw8AbHXIjpEs3/KrNo4gslXk4hzaKvnc0yR87GHQc2osl50nQFVwO9IRB5qJnS2vGwwUmy+oM/NEQhbLwsWtbF9N/7LX/S91CtcpYyh2GZnAYkjeolSXniLou08OnbbXt0C3iufR3fnyz9FtjT+kwV50Bsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814572; c=relaxed/simple;
	bh=zzf7ynHDir4h8dqc/IvxWIScwTBEWq99xOmvep74PIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MVFF6NH51JTdmpuR/78OoBmTrBp1j9ef7zgeB9bXbv2wH9VvDFyIhbP0HORKnfFXc3PzG+F8DDfD6I2RjTGHaGqxzy2qIglJb1tpDqi1XQRfhO2+xJyCj0r6z2hEpZ+qFe5WZnPUwYHpYS4n6MQCUv37gTHgDDWatweRAgOshLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A92cE4Tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A92cE4Tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E2C116C6;
	Sun, 29 Mar 2026 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814572;
	bh=zzf7ynHDir4h8dqc/IvxWIScwTBEWq99xOmvep74PIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=A92cE4TwKwJDbRBr1umh+Ut2PW8UwVJe4cs4wkviohYXKBCWGV1AGGJVu95V5zK74
	 QO4iFC/sbb/8R/ugL9BWA1k9AVrNVCMoVevs9tEChMQYyQRajXmST82GOpYhyMEhp5
	 vdKfdzsP5HATMLob0pBqSU28GE17An4RUkAi9fGfMPFbN870q34Tnsjz4qeWQaFbr2
	 fN6zK1QdfwX12aJHsnYoc7dmOo/dwNF3NEg7hiWlyxcrVawlADevlK8VmxCGxMEMB0
	 9KZIqPHvB/iSsAK/f2ot4GfPC4JlthSln2ruy8gEr9mzW2SsuuFEmTwAC7xEInA/3D
	 Vy+xHBIShhT3A==
Date: Sun, 29 Mar 2026 22:02:49 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Akshai Murari <akshaim@google.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: add keycodes for contextual AI usages
 (HUTRR119)
In-Reply-To: <acatScfJMhlD2uOj@google.com>
Message-ID: <30137112-rqp5-4s71-247p-r79878rosqp0@xreary.bet>
References: <20260327065446.3467352-1-akshaim@google.com> <acatScfJMhlD2uOj@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Mar 2026, Dmitry Torokhov wrote:

> > HUTRR119 introduces new usages for keys intended to invoke AI agents
> > based on the current context. These are useful with the increasing
> > number of operating systems with integrated Large Language Models
> > 
> > Add new key definitions for KEY_ACTION_ON_SELECTION,
> > KEY_CONTEXTUAL_INSERT and KEY_CONTEXTUAL_QUERY
> > 
> > Signed-off-by: Akshai Murari <akshaim@google.com>
> 
> Jiri, Benjamin, how do you want to merge this?
> 
> Just in case:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Perfect, thanks a lot Dmitry. Now in hid.git#for-7.0/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

