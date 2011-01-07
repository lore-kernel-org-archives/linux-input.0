From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v2] Documentation: Add evdev type and code definitions
Date: Fri, 07 Jan 2011 17:36:57 -0500
Message-ID: <4D279589.1060107@canonical.com>
References: <1294435695-16750-1-git-send-email-chase.douglas@canonical.com> <4D278E6B.7020002@gmail.com> <4D279075.4080503@canonical.com> <4D279325.3040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D279325.3040205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/07/2011 05:26 PM, Nikolai Kondrashov wrote:
> On 01/08/2011 01:15 AM, Chase Douglas wrote:
>> Hmm.. That seems incorrect to me. Why wouldn't it follow the behavior
>> outlined above?
> Because the tablet doesn't report when the tool enters/leaves the proximity.
> It just starts/stops sending the coordinates.
> 
> A leave timer could be used, though. Maybe we could ignore the case when the
> mouse is laying still on the tablet or the pen is held very steadily in
> place and just tell that tool left the surface.
> 
> Maybe it will be beneficial to have it synthesised after all, as it would
> probably ease the integration with xf86-input-wacom and will keep the evdev
> protocol more consistent.

I think I understand now, and it sounds pretty broken :). Do we want to
codify such behaviour, or leave it out as a special case? I don't see
this document as a definitive guide to evdev usage and driver
development, just a reference and best practices guide, so I'm inclined
to say the latter.

-- Chase
