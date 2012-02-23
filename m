From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 2/2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Thu, 23 Feb 2012 16:05:46 +0530
Message-ID: <4F461682.4020503@st.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com> <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:52490 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753601Ab2BWKgS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 05:36:18 -0500
In-Reply-To: <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Mirko GARDI <mirko.gardi@st.com>

On 2/23/2012 3:10 PM, Viresh KUMAR wrote:
> Thaw and poweroff routines are missing for spear-keyboard. They are required for:
> - Error case scenarios during freeze
> - Using test features, of hibernate.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Sorry for the duplicate SOB :(

-- 
viresh
