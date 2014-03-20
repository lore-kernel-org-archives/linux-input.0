From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Thu, 20 Mar 2014 17:21:59 +0000
Message-ID: <20140320172159.GA27400@srcf.ucam.org>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395310330-3232-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 20, 2014 at 11:12:08AM +0100, Hans de Goede wrote:

> Which in the end turns out to be much nicer too, since it gets rid of needing
> a udev-helper too. After this much too long introduction I'll let the patches
> speak for themselves.

Yeah, I was coming to the conclusion that this was probably the best we 
could do. It's unfortunate that "id" is already in use - we'd be able to 
get away without any X server modifications otherwise.

Long term we probably still want to tie serio devices to the ACPI 
devices in case the vendor provides power management calls there, but we 
can leave that until there's an actual example.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
