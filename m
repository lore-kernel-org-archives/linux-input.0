From: simon@mungewell.org
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Sat, 30 Jul 2011 22:52:07 -0400
Message-ID: <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>
References: <1436421.MlUiXUhh2P@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:38062 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1GaCwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 22:52:12 -0400
In-Reply-To: <1436421.MlUiXUhh2P@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, simon@mungewell.org

> This is the first out of five patches me and Simon Wood (CC'd) have been
> working on.

As a formality I should state that I support this series of patches. I
think moving the FF code from 'hid-lgff.c' to 'hid-lg4ff' will enable us
to implement more features in the future without risk of inadverantly
affecting other (non-wheel) devices.

I have tested this code against the WiiWheel and DrivingForcePro.

signed-off-by: simon@mungewell.org

Cheers,
Simon.

