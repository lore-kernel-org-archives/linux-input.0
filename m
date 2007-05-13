From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix spitzkbd compile warnings
Date: Sun, 13 May 2007 09:16:34 -0400
Message-ID: <d120d5000705130616r4f0f43a6y4ff7dc6ba8134bc7@mail.gmail.com>
References: <1179059748.5883.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1179059748.5883.3.camel@localhost.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Richard,

On 5/13/07, Richard Purdie <rpurdie@rpsys.net> wrote:
> Fix compile warnings from spitzkbd.c. Registration failure of these IRQs
> isn't fatal so just warn about it.
>

Could we also print error codes returned by request_irq()?

-- 
Dmitry
