Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5D175A63;
	Wed,  8 Apr 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681008; cv=none; b=UZeIv8fWztL23ftu3crvxeU+qtWyvrKDh4zrrH4yBieJrPu94xKAOya3bfQNllI+PvWXL8cR8FqX0mPUBnxZAz3RkmXJORNxUkAc4lSurrczJf3oiI3LQb2nP8nyECUMd4bj5HONVGuAP+7SQHSbjJTCduIZldzAsLfMYPlO0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681008; c=relaxed/simple;
	bh=g8EVwPjvSIhnF8ig4PpMNwGDpqCi2kZZTu9DWS5mrm4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qP7Kh9jicdNKsEYgVd4B0TlyM9wi7UtCQvNAMYTWcXCiHgOoBUa+yJIJOdFQRlo1MjBjSenBqDVgn+tImE4kA2O30O5fw9VMaXm4TZcbU1RmfuKjP1TSFxP3IysySs/05aUXAxs3MF4zpEmBmta995gTPoOh0hd+6JHIswWjwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD+Q7tz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD+Q7tz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4E2C19425;
	Wed,  8 Apr 2026 20:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775681007;
	bh=g8EVwPjvSIhnF8ig4PpMNwGDpqCi2kZZTu9DWS5mrm4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mD+Q7tz/Mxbf7/fhrcaMKNkXcfIohL5PqS2wDyINDiTx5jziPCkPWIJh6Z1LfGAlU
	 RXRSD0XAdYT6SbuPHfuOJalltef8WZvt0EEY6CrqIRF497ZuiOLnlwjgBfzXkWjoin
	 gvzNpQZ3JgI/FFHF5GETwG5i3wg88LECL6TkywMXAsqjzQQzvnxtrGd9h0nm/ZeuuJ
	 C4EDW5R9oqBpZgHLi7kFXEE6GxUacKpWIIM9FMzLOIkqtXTmhdu3lrZki8e4afqaeg
	 /76p0c8bu9h8VBV+1rxBO1JzCX0myPzhtshU1xvkIvFh71VkpsjoMTK0soT5XZ4ilt
	 j3g8ezfln3Rbw==
Date: Wed, 8 Apr 2026 22:43:25 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: quirks: update hid-sony supported devices
In-Reply-To: <20260407195327.10698-3-rosalie@mailbox.org>
Message-ID: <85o837p9-q452-39s0-ns20-nppr62r22o0r@xreary.bet>
References: <20260407195327.10698-3-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Apr 2026, Rosalie Wanders wrote:

> hid-sony has been updated with new device support, update the
> hid_have_special_driver list accordingly.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Now in hid.git#for-7.1/sony, thanks.

-- 
Jiri Kosina
SUSE Labs

