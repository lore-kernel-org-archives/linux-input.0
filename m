From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Wed, 2 Jan 2013 01:24:05 -0200
Message-ID: <CACo8zOd=Si4xFnJPKeknSJCyxjH7P5RibpGt787mnBjdCU8ZAg@mail.gmail.com>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
	<CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
	<CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
	<CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
	<1357069586.8915.11.camel@localhost>
	<CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
	<1357073810.8915.14.camel@localhost>
	<CACo8zOe6muNzxE+u-V3dFD27e-2h9w7267Pk3SAUZFsF-Ok9Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:40956 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3ABDYH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jan 2013 22:24:07 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so6447713wgh.7
        for <linux-input@vger.kernel.org>; Tue, 01 Jan 2013 19:24:06 -0800 (PST)
In-Reply-To: <CACo8zOe6muNzxE+u-V3dFD27e-2h9w7267Pk3SAUZFsF-Ok9Vw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-input@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, Jiri Kosina <jkosina@suse.cz>

As you can see on the paste, there are no add events for the power_supply
infrastructure which causes upower not noticing it was added, the same
happens when removed:
http://paste.kde.org/635294/

Best,

--
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com
