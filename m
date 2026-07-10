Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13603672BA;
	Fri, 10 Jul 2026 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657166; cv=none; b=fAj3RZ0+U6wTS5vVPGqu7Xrk56SEaRpfFFd0Id3nkppKJTR7SB1TezbgfuM76iA7Lmr0yoyXAuyF2jWX4BalUuAnaqoZtZZ6zVSia4TiCtcoFId9PI63nZNHu1RVeWyaBUsSEBwpVzlL99vszP4nAptfNiYDmR+u8mUuDi6zffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657166; c=relaxed/simple;
	bh=KsSMxz6mJpzugjWkY6KCCcddcj30vcSLC8Isde+h6OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDai8iHHjojy/WSUBbWbu4oP0vFIkdf895DY8k0RS0ds+ezZkCopGPowzlM5cYBsqrQCIferiI0WKVJNTjL/d2m3hgR/iH6g0Nizy44vHRD06EeDL5yjJfgTEX9eioZv0QprQjqIR1moRv5uSLj5MGT+ShdMHAx/b3XZU37I4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kta2W2N4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kta2W2N4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1B91F000E9;
	Fri, 10 Jul 2026 04:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783657165;
	bh=2jiP/Wep9xLdIKdBfxKUFknIm84Z9ZDs4/n2Kp96ezw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kta2W2N40ci6Mx/cfWhxcpyRvLA4S9j15PV9HqHeauJRONDxAd/ZRMT/cUS1BP5P4
	 s24kZviB6qMl6DmjD98SoAEAsHGeBtsZ9E9sXZ92e1SEz5ieUoSVmmFCaII+TY6ovM
	 demnBRSbAFYJdXDEcgzuHYAQoIo564CqAny7yf6r8vWUZlQUpQJAEJlV9Z6XPApCSv
	 XAiNzi9hkH3VUOcJcUkI/m35c1ub5Jxlz3CxmeV2RAo9kZhzNkS+A+6cVU0JXp8eXl
	 5ESzh5nV09wtfCh5kis9BeNoq+tv5vNJO5yqGiDkTL70Ojc6x9N9PSPulks8/LuuMt
	 9IZq0ifHqVTwQ==
Message-ID: <7c76209b-858e-4e20-a867-86bcc8efc198@kernel.org>
Date: Thu, 9 Jul 2026 23:19:23 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: i2c-hid: Fixes "(null)" device name error logs in
 i2c_hid_parse
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 dianders@chromium.org, treapking@chromium.org, kenkinming2002@gmail.com,
 raoxu@uniontech.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710023936.3960010-1-aichao@kylinos.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260710023936.3960010-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 21:39, Ai Chao wrote:
> Hello Doug
> 
> "Ai" is my surname, and "Chao" is my given name. My name is Ai Chao, which translates to "Super AI".
> 
>>> Before: hid (null): reading report descriptor failed
>>> After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed
>>>
>>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>>> ---
>>> change for v2
>>> - Used Fixes tag.
> 
>> Could have fooled me. ;-)
> 
> syslog:
> kernel: [    3.815131][ 1] [  T319] i2c_designware HYGO0010:00: timeout in disabling adapter
> kernel: [   15.790171][ 1] [  T319] i2c_designware HYGO0010:00: timeout waiting for bus ready
> kernel: [   15.998769][ 1] [  T319] i2c reading report descriptor failed retry:49
> kernel: [   16.038176][ 1] [  T319] i2c_designware HYGO0010:00: timeout waiting for bus ready
> kernel: [   16.246771][ 1] [  T319] i2c reading report descriptor failed retry:50
> kernel: [   16.246775][ 1] [  T319] hid (null): reading report descriptor failed
> kernel: [   16.246778][ 1] [  T319] i2c_hid i2c-TPD0001:00: can't add hid device: -5
> kernel: [   16.246954][ 1] [  T319] i2c_hid: probe of i2c-TPD0001:00 failed with error -5
> 
> 
> Thanks,
> Ai Chao
> 
> 

The point was that there is no "Fixes" tag added above your SoB, but you 
mentioned that there was one in your changelist.  Identify the commit 
that you're fixing (use git blame for example) and then add it to the 
commit text above your SoB in the correct format.

# git log -1 --format='Fixes: %h ("%s")' $commit
