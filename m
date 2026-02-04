Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D163DA7F5;
	Wed,  4 Feb 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201556; cv=none; b=DOUBBIi5Tug91c5JF6UGIHmEm56C6lsM8NqRV8CAYZQ9vc0JlbXyRsMWdDBHh4b2sMVtoz96fgIOeLTNymDzEo0a3HSq24eRe2gltZR5A1+fxJZVnYg3Z4udz86TATshlnnDLtBY78+4r03aoP8wmhEq6AbRaCodEzn1OzeVZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201556; c=relaxed/simple;
	bh=IELr6b6ExnxyYXlSyHyP+yjhU6uQ7M749l6ZbxvWAvQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dGNOwL3YcSMELQ3ADRdyGUOoRqKC6TO67jxs7DgqgX+FP5sN+AEupvm0cjk7YVrjCevHzS0FKN0jG8B31FBMEnl6Q7e51cepCDXrYF/uKu1EHvtcAVSDe+N2dlZxp+NHNI0PrN77eEkW+wbrj/qU3fsLOcxHqfGXa6PXLViLSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RskvCYrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RskvCYrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E72C4CEF7;
	Wed,  4 Feb 2026 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770201556;
	bh=IELr6b6ExnxyYXlSyHyP+yjhU6uQ7M749l6ZbxvWAvQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RskvCYrxkO4vbkDZzpmiZ533wDrGVzix2qaHjZCs38D5hsSNRO4uZI5nqP+g1ymWc
	 G6wykVb95ZJ2iDliyC9HV5d/usQUxcpWnmrUN5Su2ztIveuJOQNcWW3Aj6jG2VwyIo
	 X5aXLLgdwqNjX9Q7uCwHEU2wjKvsGzJTdHJGIi/MM4Em4/oaGYCSmmj6AKTgJXdvNo
	 lWzYhfVDVnHNWtPmUDE6uHVhxenOtTrIVARpdJ4yzh/09EvL6YxxrpxMHzjARAuqjw
	 UkKyPpS+LVhFhF1Q9FcUob9ni9HJKng2O0QjCKTeec/b3nfc/ArVw5X+7+OlvtKVeK
	 8+BVY0NljUaag==
Date: Wed, 4 Feb 2026 11:39:13 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Sahil Chandna <chandna.sahil@gmail.com>, bentiss@kernel.org, 
    connorbelli2003@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Add check for cancelling fn_lock_sync_work
In-Reply-To: <273d8509-3d2e-4686-b56f-a12c5c203291@rowland.harvard.edu>
Message-ID: <76269s1o-0465-895n-p0p0-1628sopn5324@xreary.bet>
References: <273d8509-3d2e-4686-b56f-a12c5c203291@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Feb 2026, Alan Stern wrote:

> With no synchronization between the two routines, this patch cannot 
> possibly be correct.  There's nothing to prevent the CPU running 
> asus_input_configured() from executing the assignment to 
> drvdata->fn_lock before doing the INIT_WORK() (unless the INIT_WORK() 
> call itself contains some synchronization -- but obviously the code 
> shouldn't depend on that).

Ouch, you are of course right, that escaped my attention. Thanks a lot for 
catching this, Alan!

Now dropped from the queue.

-- 
Jiri Kosina
SUSE Labs

