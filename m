From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] gpio_mouse driver
Date: Wed, 30 May 2007 08:52:08 -0400
Message-ID: <d120d5000705300552n458118bfj818ff2d5d2607da2@mail.gmail.com>
References: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
	 <d120d5000705290836o49bc207bqb3d9dfebc34ac752@mail.gmail.com>
	 <1180506198.32245.59.camel@localhost.localdomain>
	 <d120d5000705300530ie4ce2eatfec117a4e950da2d@mail.gmail.com>
	 <1180528692.32245.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180528692.32245.78.camel@localhost.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/30/07, Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com> wrote:
>
> Ok, I will pull your GIT tree sometime soon(tm), and update the patch to
> match the new standard. A bit unsure about when, but in good time before
> 2.6.23.
>

Thank you. A couple of things to remember - the merge window for new
code is 2 weeks after release of 2.6.22 and code that is merged during
that window is expected to be present in -mm for couple -mm releases
to make sure it is solid with regard to different
architectures/.configs.

> Is git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git the
> correct tree?
>

Yes. You may also get any of Linus's 2.6.22-rcX - the new code is there as well.

-- 
Dmitry
