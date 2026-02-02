Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393162ECEBC;
	Mon,  2 Feb 2026 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064136; cv=none; b=bMxYgvs13hNKy5kPzQC/V1j50+zD52G6+yGABxs2Nv3n+yYQbj/gVEuAISOLvvN54dLKLEmfy49KWGEJQUHr/sQkDm1fHjSs9cq4QWREkLCGhJKnyLk3sw8A2oCXDNhmq2ANqOw4IgVrlzhvLybSlEUajNUoLIAPtyBjuRnuToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064136; c=relaxed/simple;
	bh=6qn2+zAtl7CZYvBRYagrO8T3vFFaeUsBmkJoLEINa3M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dThWIiPIk4x4Pyx4l0ODlqaP0koR9qTmMDcx/fPIZzvcJp2zmTowtfjqRqxnkU0SFuX7O2JvJYKJtLq3WHeaC7FW3PU7iuVOzT3S2r86LD22Yjc9Y+SESVQs0ezKgGE7lgVeE7UIOvzpqcjsHj22hu9oGUzOXZGJ8Lyxe8/xgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmxptjtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmxptjtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7505DC116C6;
	Mon,  2 Feb 2026 20:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064135;
	bh=6qn2+zAtl7CZYvBRYagrO8T3vFFaeUsBmkJoLEINa3M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Qmxptjtd3Szc8aMX5AobuW0B60WI3o6uIeO6I3Jfd6+TQCAMfds9NmsGHnFRPjE8C
	 wi6xDlbJwSutrC88HnnrSYmjee4GvRrQ29Ev0m+7tnRhgG0/XlRZuW7XzGufss4Umz
	 wWsHzLCX2NgKKeGKq8f2dDUbTq2BMPg6fUN24jOfrKLg+GqeC18mhZdqH5l/xieYQf
	 ka8Slj/JDZasttslw8ksjlYhL1Hfo7cWxYh4aNm71oVjBfmVvkr8SB0antAk+Vn31k
	 Ru8taWNKs3wK8sNzHui6kZRKc3RIWeeCvI7+3ptA456pks39L00tKvzk6aEoVebhsD
	 YLGe312AKhHtw==
Date: Mon, 2 Feb 2026 21:28:53 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sahil Chandna <chandna.sahil@gmail.com>
cc: syzbot <syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com>, 
    bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] WARNING in asus_remove
In-Reply-To: <aXxOhV79TnuYaw0-@chandna.localdomain>
Message-ID: <r7845ps7-3qqp-o377-73r9-410s541452qo@xreary.bet>
References: <697baa8f.a70a0220.9914.001f.GAE@google.com> <aXxOhV79TnuYaw0-@chandna.localdomain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 30 Jan 2026, Sahil Chandna wrote:

> #syz test
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -960,8 +960,8 @@ static int asus_input_configured(struct hid_device *hdev,
> struct hid_input *hi)
>  	}
>  
>  	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> -		drvdata->fn_lock = true;
>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
> +		drvdata->fn_lock = true;
>  		asus_kbd_set_fn_lock(hdev, true);
>  	}
>  @@ -1343,7 +1343,7 @@ static void asus_remove(struct hid_device *hdev)
>  		cancel_work_sync(&drvdata->kbd_backlight->work);
>  	}
>  -	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> +	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
>  		cancel_work_sync(&drvdata->fn_lock_sync_work);
>  
>  	hid_hw_stop(hdev);

Thanks! Could you please submit this with proper changelog, signoff, etc?

-- 
Jiri Kosina
SUSE Labs

