From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] input: tablet: pegasus_notetaker: USB PM fixes
Date: Mon, 13 Jun 2016 16:12:59 +0200
Message-ID: <1465827179.15666.24.camel@suse.com>
References: <1465824713-3156-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465824713-3156-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: dmitry.torokhov@gmail.com, kernel-testers@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2016-06-13 at 15:31 +0200, Martin Kepplinger wrote:
> In close() we only need usb_autopm_put_interface(), in reset_resume()

Sorry, that is a misunderstanding. You need not carry
about power management in close() at all. But it must
be balanced of course.

	Regards
		Oliver
