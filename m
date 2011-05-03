From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [v1] Input: tegra-kbc - modify keypress wakeup logic.
Date: Tue, 3 May 2011 10:02:02 -0700
Message-ID: <1FC56210173BB445BD77F608D6FB8D032A153969F1@HQMAIL03.nvidia.com>
References: <1304382188-29530-1-git-send-email-riyer@nvidia.com>
 <BANLkTimFKzQk0u3Kwq0MXRXEjUg8xb1JOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTimFKzQk0u3Kwq0MXRXEjUg8xb1JOA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "rydberg@euromail.se" <rydberg@euromail.se>, Allen Martin <AMartin@nvidia.com>, "olof@lixom.net" <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello Dmitry

Our hardware design cannot reliably support an arbitrary set of keys waking up the system.

In contrast we can reliably accommodate the scenario where all keys can wake the system.

Our vendors agree to having all keys wake the system up rather than the unreliable solution.

Please let me know if more information is needed.

Thanks and Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Monday, May 02, 2011 5:49 PM
> To: Rakesh Iyer
> Cc: rydberg@euromail.se; Allen Martin; olof@lixom.net; linux-kernel@vger.kernel.org;
> linux-input@vger.kernel.org
> Subject: Re: [v1] Input: tegra-kbc - modify keypress wakeup logic.
> 
> Hi Rakesh,
> 
> On Mon, May 2, 2011 at 5:23 PM,  <riyer@nvidia.com> wrote:
> > From: Rakesh Iyer <riyer@nvidia.com>
> >
> > Modify wakeup logic so either all keypresses wake the system or none do.
> 
> You need to provide justification for this change (i.e. why the new
> way is better).
> 
> Thanks.
> 
> --
> Dmitry
