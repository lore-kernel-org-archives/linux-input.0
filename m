From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Fix sudden warps in mousedev
Date: Mon, 26 Mar 2007 15:30:42 -0400
Message-ID: <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>
	 <200703250134.03416.dtor@insightbb.com>
	 <20070325111930.f6428509.zaitcev@redhat.com>
	 <200703252319.39676.dtor@insightbb.com>
	 <20070326121718.3940a579.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070326121718.3940a579.zaitcev@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 3/26/07, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Sun, 25 Mar 2007 23:19:38 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:
>
> > I tried to reproduce warping on console but could not for some reason. Could you
> > please try the patch below and tell me if it fixes the problem for you?
>
> > +++ work/drivers/input/mousedev.c
> > @@ -124,32 +124,33 @@ static void mousedev_touchpad_event(stru
> > -                             if (mousedev->pkt_count >= 2) {
> > +                     if (mousedev->touch && mousedev->pkt_count >= 2) {
>
> This works, thanks a lot.
>

Great! Then I'll queue it for 2.6.22.

> The double-indented switch() is annoying, but since the whole driver
> is written to the same style, I can live with it, for the uniformity
> purposes :-)
>

Yes, the whole input is like this so I keep it consistent.

Regarding the synaptics driver and scroll problem. Yesterday I
scrolled twice through entire Remarque's "Spark of Life" off lib.ru
(once with 0.14.2 and once with latest git pull) and did not see any
scrollbar getting "stuck". Could it be newer xorg problem instead of
individual driver problem? I am using whatever xorg was installed in
FC3 which is somewhat dated... Also, could it be that the scroll issue
happens only in a certain application?

-- 
Dmitry
