From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Fix sudden warps in mousedev
Date: Tue, 27 Mar 2007 11:14:31 -0400
Message-ID: <460934D7.9030700@redhat.com>
References: <20070324001610.724a820a.zaitcev@redhat.com> <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com> <20070326144206.93805eeb.zaitcev@redhat.com> <200703262114.45287.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703262114.45287.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> 
> The driver grabs tochpad with EVIOCGRAB ioctl to prevent input events
> from bveing delivered to X through /dev/input/mice which is still in
> whidespread use. That's why evtest does not work. We could as Peter
> (CCed) to implement an option to turn off grabbing so users who don't
> use mousedev multiplexor can use evtest and other commands.
> 

What should people be using instead of /dev/input/mice ?

And why did the mouse numbers all get rearranged in 2.6.20, e.g.
mouse1 became mouse2 for many people?
