From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix spitzkbd suspend key handling
Date: Thu, 3 Jan 2008 11:16:02 -0500
Message-ID: <d120d5000801030816o697219d8h664b2823e1965cfc@mail.gmail.com>
References: <1199233037.4653.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755200AbYACQQT@vger.kernel.org>
In-Reply-To: <1199233037.4653.44.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Jan 1, 2008 7:17 PM, Richard Purdie <rpurdie@rpsys.net> wrote:
> The spitz keyboard driver reports KEY_SUSPEND events but doesn't
> register its use of this event in the keybit bitfield, breaking input
> events for this key. This patch fixes that by registering the key in the
> keybit bitfield.
>

Applied to my tree - for-linus branch. Thank you Richard.

-- 
Dmitry

P.S. Try to migrate to linux-input@vger, I'd like to get off atrey server
