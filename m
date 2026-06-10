Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6B2DC782;
	Wed, 10 Jun 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105971; cv=none; b=b0WNIeMq/8mUlPNDB6ZWrnLxCBRZQF1vN1Ap31gvdUafJ47hV3904LW+UNZzzI9yRXNQTJ8LpQo+TsV9BLt+NJu2ZS568v/FsUSHy48TfDKxIvYLp0UpffkutXTmYzmUELg5aGZMLmzOWr8J2IHVqAiDA+liUadguRqVRCO00uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105971; c=relaxed/simple;
	bh=f9EvgGS+d/nZ2MvKYODVCm6UUbTsBimO3JfKsNzf3+A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CuU7VhS4QVZJyn7JX6AEenCnuJN3bnRRPgja3/MJa2CoPoN/KDQCTqrZsRW6swGmcXrjYnhoBAtfFMAnahbYBIFimqv7/5jQGpwFTHoqC+yUlt+m+fmNampGXeYxZjdOD4fv6xj5xtscUlqE5+d8igar23ye3ZO4Hl+0Wy/c1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyB8qpoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyB8qpoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFEE1F00893;
	Wed, 10 Jun 2026 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105970;
	bh=bhIWjX0kFJJ843ZMSrW2sH8KXnG1q0jKN6ajqqPDnhA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=jyB8qpoE5lfjpLGskCmSegtNqFtQIMd5CbLgq2V0DjTuwo3VdhodzyqF0XmbZqDVs
	 9CDDgoLpLllWQuIcTsHlXm0wnddXW3Lv0hdt2rjCcdQMlYVG0TpzSKW/nji32wwDp/
	 ep3jYwtvvy9tlkASo/6D87K7qZttRFGairJsPqHMCGveo3/LVh4vuAUQmL6mLl1ZWz
	 X0T0d0YhIxnTxFjbUsy4BX1AE/WK/Tg/4R+wR6K5lC9DJPNyF6DPfIJiEEsSXgDyZE
	 +9JUuY15I66aQKTUWpZWCJY3wiEmwlbsLBRh4L2TzOG4zDZI57izYGLEpUOyK9cJuq
	 P4SImFPo1Vvqg==
Date: Wed, 10 Jun 2026 17:39:25 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: bentiss@kernel.org, derekjohn.clark@gmail.com, mpearson-lenovo@squebb.ca, 
    vsankar@lenovo.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: lenovo: Add support for ThinkPad X13 Folio
 keyboard
In-Reply-To: <CABxCQKtr1g8xEg_EYEQhjsgAR7QtSQ0dDQhOAByuxvHBeHK5iA@mail.gmail.com>
Message-ID: <09prqp54-684n-r4q1-02or-1nqr1s4516on@xreary.bet>
References: <20260522050632.8079-1-vishnuocv@gmail.com> <CABxCQKtr1g8xEg_EYEQhjsgAR7QtSQ0dDQhOAByuxvHBeHK5iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Vishnu Sankar wrote:

> Hi Jiri / Benjamin,
> 
> Gently pinging on this series.
> Is there anything blocking acceptance or any changes needed from my side?
> The series has been tested on physical hardware.

Sorry for the delay. Now applied to hid.git#for-7.1/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

