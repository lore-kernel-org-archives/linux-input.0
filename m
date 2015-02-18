From: simon@mungewell.org
Subject: Re: [PATCH] HID: hid-lg4ff: Fix "undefined reference" build issue
 with CONFIG_USB disabled.
Date: Wed, 18 Feb 2015 17:47:32 -0500
Message-ID: <ca6b7db304af2585db3e95a7d81311a0.squirrel@mungewell.org>
References: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39689 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbBRWrg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 17:47:36 -0500
In-Reply-To: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, =?iso-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>

> Fix "undefined reference" build issue with CONFIG_USB disabled.

Just a newbie question... for a family of devices (the wheels) which can
only be attached via USB, wouldn't the better approach be to fix the
dependancy?

Are there any other devices provided for by 'hid-logitech' which use any
other transport (HID over Bluetooth or the like)?

Simon.

