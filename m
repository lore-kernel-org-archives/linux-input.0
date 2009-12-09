From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] dell-laptop: Update rfkill state on kill switch
Date: Wed, 9 Dec 2009 12:07:45 -0800
Message-ID: <20091209200745.GB10138@core.coreip.homeip.net>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com> <1260383609-7681-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260383609-7681-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 09, 2009 at 01:33:29PM -0500, Matthew Garrett wrote:
> The rfkill interface on Dells only sends a notification that the switch
> has been changed via the keyboard controller. Add a filter so we can
> pick these notifications up and update the rfkill state appropriately.
> 

This needs Kconfig love for the case i8042=m dell-laptop=y

-- 
Dmitry
