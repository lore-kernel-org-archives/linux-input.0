From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd.c: make the unknown key warnings controllable
	thru a config option
Date: Mon, 30 Jun 2008 08:21:30 -0400
Message-ID: <20080630081937.ZZRA012@mailhub.coreip.homeip.net>
References: <20080629225423.A23524@ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:26234 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761430AbYF3MVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 08:21:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so291665and.103
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 05:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080629225423.A23524@ward.six>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Denis,

On Sun, Jun 29, 2008 at 10:54:23PM +0600, Denis Zaitceff wrote:
> The patch allows to configure off the logging of ATKBD_KEY_UNKNOWN
> events.  This logging can be healthy, but usually it just pollutes the
> kernel log.  And this logging may be _very_ massive.
> 

You can easily shut off the warnings by actually mapping the key,
so there is no need to add a new config option.

Thanks.

-- 
Dmitry
