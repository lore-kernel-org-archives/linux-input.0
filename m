From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 04 Jun 2011 16:22:53 +0200
Message-ID: <4DEA3FBD.8020602@absence.it>
References: <4DE8FC4A.9010401@absence.it> <4DE8FFE0.5070506@absence.it> <20110604084338.GD7194@kamineko.org> <20110604124219.GA14809@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110604124219.GA14809@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 04/06/2011 14:42, Matthew Garrett wrote:
>> one thing I'm wondering is if we shouldn't stop sending input
>> events also via the acpi bus rather than adding new notification
>> methods. The /proc/acpi/event notification will go away on its own one
>> day so maybe letting this habit die with it is a reasonable deprecation
>> plan for /proc/acpi/event users.
>
> Yeah, it's about time for this to die.

Sorry, I don't understand what should be changed and the desired behavior:
1) no acpi notification at all, neither proc nor netlink (but we need 
some new entries in input.h first).
2) no acpi notification for hotkeys events only.
3) no acpi notification to the deprecated /proc/acpi/event only
