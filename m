From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Add hovering distance axis
Date: Tue, 7 Dec 2010 02:41:18 -0800
Message-ID: <20101207104118.GB2817@core.coreip.homeip.net>
References: <1291710468-2022-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291710468-2022-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 07, 2010 at 09:27:48AM +0100, Henrik Rydberg wrote:
> Touch devices capable of hovering, i.e., fingers detected a distance
> from the surface, are not supported by the current input MT
> protocol. This patch adds ABS_MT_DISTANCE, which may be used to
> indicate the distance between the contact and the surface.
> 

Makes sense.

Thanks.

-- 
Dmitry
