From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] Input: synaptics - print firmware ID and board
 number at init
Date: Mon, 2 Jul 2012 14:37:15 +0200
Message-ID: <20120702123715.GA1898@polaris.bitmath.org>
References: <1340859117-19654-1-git-send-email-djkurtz@chromium.org>
 <20120702072740.GA624@polaris.bitmath.org>
 <CAGS+omCy9g8Q6gJhcgMatr+jWPkAzHge6sZOR8HOM92+-xBhXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omCy9g8Q6gJhcgMatr+jWPkAzHge6sZOR8HOM92+-xBhXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > Is there a specific usecase for this, except the nice-to-have?
> 
> Use cases (these are all very real use cases, that we use today, they
> are not hypothetical):
>   * To include firmware and hardware versions in user feedback reports.
>   * Used by factory tests to ensure systems are being built and
> deployed correctly.
>   * Lastly, these are also precursor patches for a larger set that
> adds firmware update capability.  A userspace firmware update script
> can use these APIs to determine which file to load and/or whether such
> a load is necessary.

Thanks. Future firmware update patches is the prime reason for the
sysfs interface, IOW.

> If there is a standard non-driver-specific way of achieving these use
> cases, I'd be happy to modify the implementation to adopt that
> standard.  From what I've seen, however, it looks like most drivers
> have their own ad hoc way of exposing device/vendor specific
> properties.

Precisely. If there is no standard, it is quite alright to try to come
up with one. Otherwise we might as well leave all firmware-related
code in userspace.

Thanks,
Henrik
