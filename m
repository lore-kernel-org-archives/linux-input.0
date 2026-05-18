Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4C40584E;
	Mon, 18 May 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112313; cv=none; b=uLUvljsN8XdhZRQwRX6zqjR9N4dzbiZ02lypn0YzxKpf2A0DN29sdKEO+bn7rrRXD++PpYunj6lQoJI6DITp6FIDzdVLzLbsMCEVlhR7+wS7SXs054OojV0u3UM+U8NYyKOnJAA+10axM4tXHqsdg66KxX1YtWU9TFM86I5KJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112313; c=relaxed/simple;
	bh=Ji5v3MCjimwUT7RwInhuJ/9VvzwbhkzrioR3JRlDaDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSHU24kMJcAWhYWqQ+iXFjoG/4ER32bkdE61WF5uTIm+dOuGbLK0LuK/L9VvQ5gZGYSQgbpZOmhpICMFRoiGrsFVmKHhkjLlBhvGgiEIe0APZICHJhYdOr6+11SkkRMgCgVkt4xL0UJFr4hhTw2+NWuo6Ic189L2ggvnG3V19qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5c3ZoOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5c3ZoOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E174C2BCB7;
	Mon, 18 May 2026 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779112312;
	bh=Ji5v3MCjimwUT7RwInhuJ/9VvzwbhkzrioR3JRlDaDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5c3ZoOWrKzOB99N3gDQfX0gh37J2tLxuTz+j0aqZBSW3VS4BC3WKANXBxeTTpBOp
	 rM+LHwcmUlfOGncbQVoWd7a5tsy+j6+W5194P8bPNI7msHvCjKBICFZIVxK77QgsB+
	 TkF/TRoeysRQ+pgvqK5ImJYgttiHcYD9QioadKbKHHU+Lpgwf3fZxc36o323HDKY/q
	 k3iswEk2BeQu1lPI294Q1E8bayX07on5tRF7M362hp8iHYcUYm5+MQ/9OaNquRYQWf
	 11ZJ/7yXWXmCveo+blep3gwkE1mJN/df11AaVP9WJDXfbe0flWHHqEggMQAE8tOUWr
	 rfsv5xEo/7J3g==
Date: Mon, 18 May 2026 14:51:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: "Zhang, Lixu" <lixu.zhang@intel.com>, "jikos@kernel.org"
 <jikos@kernel.org>, "srinivas.pandruvada@linux.intel.com"
 <srinivas.pandruvada@linux.intel.com>, "Lechner, David"
 <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "andy@kernel.org" <andy@kernel.org>, "sakari.ailus@linux.intel.com"
 <sakari.ailus@linux.intel.com>, "linux-input@vger.kernel.org"
 <linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup
 and cleanup
Message-ID: <20260518145143.63e2c570@jic23-huawei>
In-Reply-To: <agoi55wCo//eY1YQ@hu-ckantibh-hyd.qualcomm.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	<SJ0PR11MB5613D4ECB8081985C3F2D82293072@SJ0PR11MB5613.namprd11.prod.outlook.com>
	<agoi55wCo//eY1YQ@hu-ckantibh-hyd.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 01:49:51 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On Thu, May 14, 2026 at 02:47:52AM +0000, Zhang, Lixu wrote:
> > Tested-by: Zhang Lixu <lixu.zhang@intel.com>  
> 
> Hi Zhang,
> 
> Thanks for the testing and validaiton.
> I hope you validated the complete series, including the unbind flow for the
> drivers using devm API.
> 
> Hi Jonathan,
> 
> How should we take this series forward? should I extend the series to
> cover remaining HID IIO drivers for this devm API, or this series can
> applied to IIO tree first and sent followup patches on top of that?

There is just enough minor feedback on various patches that it needs
a v4 I think, or response to those bits of review feedback to argue
against the requested changes.  

I'd like to see the new API applied everywhere unless there is a reason
it's not suitable.  Key aim being that the last patch should remove
the now unused non devm functions or maybe make them private if
they are still useful from a code structure point of view.

We may be waiting on testing though for some of them so make sure
it is clear what Zhang has tested (obviously not the stuff you haven't
sent yet :)

Jonathan




> 
> Thanks, Sanjay
> 
> >   
> > >-----Original Message-----
> > >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >Sent: Saturday, May 9, 2026 6:11 PM
> > >To: jikos@kernel.org; jic23@kernel.org; srinivas.pandruvada@linux.intel.com
> > >Cc: Lechner, David <dlechner@baylibre.com>; nuno.sa@analog.com;
> > >andy@kernel.org; sanjayembeddedse@gmail.com;
> > >sakari.ailus@linux.intel.com; linux-input@vger.kernel.org; linux-
> > >iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > >Subject: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
> > >cleanup
> > >
> > >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >
> > >Key highlights:
> > >- Prepare change as pre-requisite for devm conversion for HID IIO
> > >  drivers by removing redundant argument
> > >- Add devm API to setup trigger and clenaup resource using
> > >  devm_add_action_or_reset()
> > >- few cleanup and prepratory changes before updating driver for devm_
> > >- few sample driver update using devm conversion to auto release resource
> > >
> > >changes in v3:
> > >- Added cleanup and prepratory changes before adding devm_ API
> > >  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> > >- Address andy's review comment on commit message and coding style
> > >- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-
> > >sanjayembedded@gmail.com/
> > >changes in v2:
> > >- Following input from Jonathan and Andy, squash initial patch v1
> > >  series in single change as individual change should not break anything
> > >- Add devm API support and two driver using the same
> > >- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-
> > >sanjayembedded@gmail.com/
> > >
> > >Testing:
> > >  - Compiled with W=1
> > >  - Build-tested on QEMU x86_64
> > >
> > >Based on further feedback and reviews, I would extend this series to convert all
> > >HID IIO driver to use devm_* API.
> > >
> > >Thanks,
> > >Sanjay Chitroda
> > >
> > >
> > >Sanjay Chitroda (9):
> > >  iio: hid-sensors: drop redundant iio_dev argument
> > >  iio: hid-sensors: cleanup codestyle warning
> > >  iio: hid-sensors: introduce device managed API
> > >  iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
> > >  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
> > >    devm API
> > >  iio: humidity: hid-sensor-humidity: cleanup codestyle check
> > >  iio: humidity: hid-sensor-humidity: use common device for devres
> > >  iio: humidity: hid-sensor-humidity: use local struct device
> > >  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
> > >    using devm API
> > >
> > > drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
> > > .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
> > > .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
> > > drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
> > > drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
> > > drivers/iio/light/hid-sensor-als.c            |  4 +-
> > > drivers/iio/light/hid-sensor-prox.c           |  4 +-
> > > drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
> > >drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-  drivers/iio/orientation/hid-
> > >sensor-rotation.c |  4 +-  .../position/hid-sensor-custom-intel-hinge.c  |  4 +-
> > > drivers/iio/pressure/hid-sensor-press.c       |  4 +-
> > > .../iio/temperature/hid-sensor-temperature.c  |  4 +-
> > > 13 files changed, 78 insertions(+), 64 deletions(-)
> > >
> > >
> > >base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
> > >--
> > >2.34.1
> > >  
> >   
> 

