Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAB3E7BBF;
	Mon,  1 Jun 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337909; cv=none; b=NuDXKE5A8Gf2gqEsyhEYGJ/LN0VcHECNKQ7cFqKj0UU6h4W4Y4tKJHhhvqgVd32Lz4SKutCZX5ra4crWZW/5SiygUOCy81qSftT4XWvw/CHUUvcHAosnaemmGPPJMfp7hlHbH6PificMNDef82DfXxxjs+d4PnXYjSWl+PhYss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337909; c=relaxed/simple;
	bh=dj2H6kIv6rnZPhSti/K/Eb3ySD5rsPwGl5UG/RauDvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wk9a6hIDe9KmCej1KUJQobkPBNdlZkOgBgungEWyOB93/6iD5AAPhkxc1TKPglLHNmooE3lp50aLjOhM/u8ef59gxHs9TVYkyTgLKmSSLQhF5foqLvCG6tPG9n6K3rrejV2WXKrE9sQ1SB9lFUGmIY6j/5HBQiLvFdRDVZHDjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql4n9u2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql4n9u2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6841F00893;
	Mon,  1 Jun 2026 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337906;
	bh=vCayoE7DXDoPBlSeiwHr7yyf6Locajghjja0TA9JoQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ql4n9u2/n8nd8Dxt/ygbLepNj9ux3UtuaUvL2FAEDC/5LhUTYi6iQxy3iO+QFb2bS
	 qfv1deX10YuexBUXNBPv2KBoE9gMT8yXbVf7J2bklWB15t1qhSvTCUeBhBteMs7zbj
	 V8mFcWVXFySmNEINDM8/fiWOrcvdPXq4giOPlcwHvXc2C88bL3grRbKAetCCz43kTC
	 jO9/QgHgZekh9x/6lG3NWRiZ1NvcM8RLMSWIAT7o5V/95KkN7kyJRyxIDHDKnzFy5Z
	 fnZ2uWnTYTnEm9Y2uJq6NT7SpmDFwtutb3ulKuA+01P6Wr6Jcg3f2wJRR3FPAqrmRw
	 cwapoEULwjx4g==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
Subject: Re: (subset) [PATCH 00/11] HID: storing pointers in
 'hid_device_id::driver_data'
Message-Id: <178033790440.13649.5618816147738994428.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 18 May 2026 17:06:19 +0100, Pawel Zalewski (The Capable Hub) wrote:
> The <linux/mod_devicetable.h> has multiple structs that follow
> the pattern of having either 'driver_data' or 'driver_info'
> fields which are of the 'kernel_ulong_t' type. Then how to
> interpret that field is user defined, some users will treat
> the value as an actual integer, others as a valid pointer to
> dereference.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/cleanup_driver_data), thanks!

[05/11] HID: hid-belkin: clean up usage of 'driver_data'
        https://git.kernel.org/hid/hid/c/4de4b8a5ddc2
[06/11] HID: hid-cypress: clean up usage of 'driver_data'
        https://git.kernel.org/hid/hid/c/73e784ddf895
[07/11] HID: hid-gfrm: clean up usage of 'driver_data'
        https://git.kernel.org/hid/hid/c/0b8bb8c3c913
[08/11] HID: hid-ite: clean up usage of 'driver_data'
        https://git.kernel.org/hid/hid/c/b11dfa6cc3c8

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

