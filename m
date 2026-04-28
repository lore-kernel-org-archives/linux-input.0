Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393E332628;
	Tue, 28 Apr 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393412; cv=none; b=c43JPVvPiRxsftiMsdca9PCiEuiBVqHQdmoCtDKX6i8nB+8zLzKKxYp9FZQ9XSbsQ/0Js1oet2HrtOq5oXklGtfVPG3JsO7o0DQIeM9OSb3hz6/UZp/38dKvHoEB+ItkMNAUMe5MsGWYhpa6Ue/JDfeNtsA1rSJtq/esgwgZwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393412; c=relaxed/simple;
	bh=1CP62job1FKC3+TgQGHiBCAv7E8h0Hi77PXOFei1How=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YMzBFiDQ96umSQRcfnA+XvluOs0tF3VxQqQJMtW0iTR/b+ocdKMldfnfJHkVnHnwceQyHw6XQuKofM3mybSo09YYNmSibGhcrUosYjPl0DhulZsnLQniukD7DpqsPTHRYuKzCOCYBAPkiMomukb6E0pyXu0maQfmmN8lHotTGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeiaA9I4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeiaA9I4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F42C2BCB5;
	Tue, 28 Apr 2026 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393412;
	bh=1CP62job1FKC3+TgQGHiBCAv7E8h0Hi77PXOFei1How=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XeiaA9I4xIoWF6iAtbIl8aHIMmUCnrNiM1+ZUoanuymoVkK6ARjDEiCziITCYP+zF
	 jHcDm+TkxecoKQ4WGGrWpJolGW76pLQfE8AqcOMpnTB1ESszbZgyD2g/ye5Wg7s+z7
	 Gs5k8oM7y62OA9ezTKIlBQi8dE0urYY4CE5xvSHcpd8xXQZ89DpzfaEYI1LEwvV0Ab
	 fpDRNEEG/9VY9kap6Cyq6Gz1hzL2uVdl6bJWyjYacv6gsHCibhMEyVRbzTzwznqQx/
	 PuY7xqX2k3GdJ/48WojNFi3+4IQrNU7my+/FWEpzh7Fmp3VwwTpcZifZT6lZM7T9xT
	 9O/fJ34ihg/uw==
Date: Tue, 28 Apr 2026 18:23:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: fix incorrect force-feedback check in
 sony_suspend()
In-Reply-To: <20260410195353.4321-2-rosalie@mailbox.org>
Message-ID: <7oq89s54-o75r-o6n8-1nnn-29no4754o27r@xreary.bet>
References: <20260410195353.4321-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Apr 2026, Rosalie Wanders wrote:

> This commit fixes the incorrect force-feedback check in sony_suspend(),
> without this the check will always be true due to checking a constant
> define that is never 0.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
> ---
>  drivers/hid/hid-sony.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 83e82a0a3327..9cfea6f40ec2 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2456,11 +2456,10 @@ static void sony_remove(struct hid_device *hdev)
>  static int sony_suspend(struct hid_device *hdev, pm_message_t message)
>  {
>  #ifdef CONFIG_SONY_FF
> +	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
>  	/* On suspend stop any running force-feedback events */
> -	if (SONY_FF_SUPPORT) {
> -		struct sony_sc *sc = hid_get_drvdata(hdev);
> -
> +	if (sc->quirks & SONY_FF_SUPPORT) {
>  		sc->left = sc->right = 0;
>  		sony_send_output_report(sc);

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

